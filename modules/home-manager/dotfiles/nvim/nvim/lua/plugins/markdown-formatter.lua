local Snacks = require("snacks")
local note_dir = "~/notes/obsidian/notes"

-- Function to sort markdown tasks: move done tasks below undone ones in a contiguous block.
local function sort_markdown_tasks()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local i = 1
    while i <= #lines do
        local line = lines[i]
        -- Check for a markdown task (supports -, +, or * as bullets)
        if line:match("^%s*[-+*]%s*%[[ xX]%]") then
            local block_start = i
            local block_end = i
            -- Find the end of this contiguous block of task lines.
            while block_end + 1 <= #lines and lines[block_end + 1]:match("^%s*[-+*]%s*%[[ xX]%]") do
                block_end = block_end + 1
            end
            local undone = {}
            local done = {}
            for j = block_start, block_end do
                local current_line = lines[j]
                -- Identify undone tasks by the "[ ]" marker.
                if current_line:find("%[ %]") then
                    table.insert(undone, current_line)
                -- Identify done tasks by the "[x]" or "[X]" marker.
                elseif current_line:find("%[[xX]%]") then
                    table.insert(done, current_line)
                else
                    table.insert(undone, current_line)
                end
            end
            -- Only reorder if both undone and done tasks are present.
            if #undone > 0 and #done > 0 then
                local new_block = {}
                for _, l in ipairs(undone) do
                    table.insert(new_block, l)
                end
                for _, l in ipairs(done) do
                    table.insert(new_block, l)
                end
                for j = block_start, block_end do
                    lines[j] = new_block[j - block_start + 1]
                end
            end
            i = block_end + 1
        else
            i = i + 1
        end
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

-- Autocmd to run the task sorter on BufWritePre for markdown files.
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.md" },
    callback = sort_markdown_tasks,
})

local function open_wiki_link()
    -- Your existing logic for extracting and opening a wiki link
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local start_index = 1
    while true do
        -- Look for a wiki link pattern: [[...]]
        local s, e = string.find(line, "%[%[.-%]%]", start_index)
        if not s then
            break
        end
        -- Check if the cursor is within the found brackets.
        -- Note: vim column indices are 0-indexed.
        if col >= (s - 1) and col <= (e - 1) then
            -- Extract the text between the brackets
            local link = string.sub(line, s, e)
            -- Remove the surrounding "[[" and "]]"
            link = link:sub(3, -3)
            -- Replace spaces with hyphens
            local file_name = link:gsub("%s+", "-")

            -- Get the directory of the current buffer
            local current_buffer_path = vim.api.nvim_buf_get_name(0)
            local current_dir = vim.fn.fnamemodify(current_buffer_path, ":h")

            -- Create the full path for the new file
            local file_path = current_dir .. "/" .. file_name .. ".md"

            -- Open or create the markdown file
            vim.cmd("edit " .. file_path)
            return
        end
        start_index = e + 1
    end
    print("No wiki link found under cursor")
end

local function update_markdown_frontmatter()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.fn.expand("%:t")
    local title = vim.fn.fnamemodify(filename, ":r")
    local alias = title:gsub("-", " ") -- Replace hyphens with spaces
    local current_time = os.date("%Y-%m-%d %H:%M")
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Determine frontmatter boundaries
    local fm_start, fm_end = nil, nil
    if lines[1] == "---" then
        fm_start = 1
        for i = 2, #lines do
            if lines[i] == "---" then
                fm_end = i
                break
            end
        end
    end

    local new_fm = {}
    local found_title = false
    local found_date = false
    local found_aliases = false
    local original_date = current_time

    -- If frontmatter exists, update it; otherwise, we'll create one.
    if fm_start and fm_end then
        for i = fm_start + 1, fm_end - 1 do
            local line = lines[i]
            if line:match("^title:") then
                new_fm[#new_fm + 1] = "title: " .. title
                found_title = true
            elseif line:match("^date:") then
                original_date = line:match("^date:%s*(.+)") or current_time
                new_fm[#new_fm + 1] = "date: " .. original_date
                found_date = true
            elseif line:match("^aliases:") then
                new_fm[#new_fm + 1] = 'aliases: ["' .. alias .. '"]'
                found_aliases = true
            else
                new_fm[#new_fm + 1] = line
            end
        end
    end

    -- If title doesn't exist, add it.
    if not found_title then
        table.insert(new_fm, 1, "title: " .. title)
    end
    -- Ensure date exists
    if not found_date then
        table.insert(new_fm, "date: " .. current_time)
    end
    -- Ensure aliases exists
    if not found_aliases then
        table.insert(new_fm, 'aliases: ["' .. alias .. '"]')
    end

    -- Reconstruct the frontmatter with the proper delimiters
    local frontmatter = {}
    table.insert(frontmatter, "---")
    for _, line in ipairs(new_fm) do
        table.insert(frontmatter, line)
    end
    table.insert(frontmatter, "---")
    table.insert(frontmatter, "") -- blank line after frontmatter

    if fm_start and fm_end then
        vim.api.nvim_buf_set_lines(bufnr, fm_start - 1, fm_end, false, frontmatter)
    else
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, frontmatter)
    end
end

-- Opens a file selector (picker) restricted to your notes directory.
local function open_note_picker()
    Snacks.picker.files({ cwd = vim.fn.expand(note_dir) })
end

-- Runs a live grep search (using ripgrep via Snacks) limited to your notes.
local function grep_notes()
    Snacks.picker.grep({ cwd = vim.fn.expand(note_dir), supports_live = true, hidden = true, fuzzy = true })
end

-- Prompts for a new note title, then creates/opens the note in your notes directory.
local function new_note()
    vim.ui.input({ prompt = "New note title:" }, function(input)
        if input and input ~= "" then
            local file_name = input:gsub("%s+", "-") .. ".md"
            local file_path = vim.fn.expand(note_dir .. "/" .. file_name)
            vim.cmd("edit " .. file_path)
        else
            print("Note creation cancelled")
        end
    end)
end

-- NEW: Daily note functions.
local daily_dir = note_dir .. "/dailies"

local function new_daily()
    -- Get current date in YYYY-MM-DD format
    local date_str = os.date("%Y-%m-%d")
    local file_path = vim.fn.expand(daily_dir .. "/" .. date_str .. ".md")
    vim.cmd("edit " .. file_path)
end

local function grep_dailies()
    Snacks.picker.grep({ cwd = vim.fn.expand(daily_dir) })
end

return {
    vim.keymap.set("n", "<leader>zf", update_markdown_frontmatter, { desc = "Update Markdown Frontmatter" }),
    vim.keymap.set("n", "<C-n><C-n>", open_wiki_link, { desc = "Open Wiki Link (Note)" }),
    vim.keymap.set("n", "<leader>zs", open_note_picker, { desc = "Find Note File" }),
    vim.keymap.set("n", "<leader>zg", grep_notes, { desc = "Grep in Notes" }),
    vim.keymap.set("n", "<leader>zn", new_note, { desc = "Create New Note" }),
    vim.keymap.set("n", "<leader>zdn", new_daily, { desc = "Create New Daily Note" }),
    vim.keymap.set("n", "<leader>zdg", grep_dailies, { desc = "Grep in Daily Notes" }),
}
