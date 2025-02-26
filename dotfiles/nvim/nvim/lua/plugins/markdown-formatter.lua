local Snacks = require("snacks")
local note_dir = "~/notes/obsidian/notes"

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
            local file_path = file_name .. ".md"
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
    local current_time = os.date("%Y-%m-%d %H:%M")
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Extract date from existing frontmatter (if any)
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

    -- Extract date from existing frontmatter (if any)
    local original_date = current_time
    if fm_start and fm_end then
        for i = fm_start + 1, fm_end - 1 do
            local line = lines[i]
            if line:match("^date:") then
                original_date = line:match("^date:%s*(.+)") or current_time
            end
        end
    end

    -- Extract unique tags
    local tag_set = {}
    local content_start = fm_end and fm_end + 1 or 1
    for i = content_start, #lines do
        for tag in string.gmatch(lines[i], "#([%w%-%_/]+)") do
            tag_set[tag] = true
        end
    end
    local tags_list = {}
    for tag, _ in pairs(tag_set) do
        table.insert(tags_list, tag)
    end
    table.sort(tags_list)
    local tags_line = "tags: []"
    if #tags_list > 0 then
        tags_line = "tags: [" .. table.concat(tags_list, ", ") .. "]"
    end

    -- Update or insert frontmatter
    local new_frontmatter = {
        "---",
        "title: " .. title,
        "date: " .. original_date,
        tags_line,
        "---",
        "",
    }
    if fm_start and fm_end then
        vim.api.nvim_buf_set_lines(bufnr, fm_start - 1, fm_end, false, new_frontmatter)
    else
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, new_frontmatter)
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
