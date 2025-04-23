return {
    "echasnovski/mini.pairs",
    opts = {
        mappings = {
            ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "%s%s", register = { cr = false } },
            -- ["'"] = false,
            -- ['"'] = false,
        },
    },
}
