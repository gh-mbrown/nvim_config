-- Building dependency fzf-native.nvim
local fzf_path = vim.fn.globpath(vim.opt.packpath._value, "pack/core/opt/telescope-fzf-native.nvim", 0, 0)
local built = fzf_path .. "/build/libfzf.so"
if vim.fn.filereadable(built) == 0 then
    vim.system({ "bash", "-c", "cmake -S . -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" }, { cwd = fzf_path }):wait()
end

local telescope = require("telescope")
local actions = require("telescope.actions")

local picker_options = {
    theme = "ivy",
    preview = true,
}

telescope.setup({
    defaults = {
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
            vertical = {
                prompt_position = "top",
            },
        },
        file_ignore_patterns = {
            "%__virtual.cs$",
        },
        sorting_strategy = "ascending",
        path_display = {
            "filename_first",
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
    pickers = {
        find_files = picker_options,
        git_files = picker_options,
        live_grep = picker_options,
        buffers = picker_options,
        help_tags = picker_options,
        man_pages = picker_options,
        quickfix = picker_options,
        keymaps = picker_options,
        autocommands = picker_options,
        treesitter = picker_options,
        command_history = picker_options,
        git_branches = picker_options,
        git_status = picker_options,
        git_stash = picker_options,
        diagnostics = picker_options,
        lsp_definitions = picker_options,
        lsp_references = picker_options,
        lsp_implementations = picker_options,
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})

telescope.load_extension("fzf")
