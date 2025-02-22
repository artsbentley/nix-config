local note_dir = "~/obsidian/notes"

local function open_wiki_link()
    -- Get the current cursor position (row and col)
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

    -- Find existing frontmatter
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

return {
    vim.keymap.set("n", "<leader>zf", update_markdown_frontmatter, { desc = "Update Markdown Frontmatter" }),
    vim.keymap.set("n", "<c-n><c-n>", open_wiki_link, { desc = "Open wiki link as markdown file" }),
}
