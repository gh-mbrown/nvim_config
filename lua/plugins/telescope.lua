return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S . -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
        }
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "%__virtual.cs$",
                    "obj",
                },
                layout_strategy = "flex",
                layout_config = {
                    flex = {
                        flip_columns = 100
                    },
                    horizontal = {
                        mirror = false,
                        prompt_position = "top",
                        preview_cutoff = 10,
                        preview_width = 0.5,
                    },
                    vertical = {
                        mirror = true,
                        prompt_position = "top",
                        preview_cutoff = 10,
                        preview_height = 0.5,
                    },
                },
                sorting_strategy = "ascending",
                path_display = {
                    "filename_first"
                },
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    }
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        "fd", "--type", "f", "--strip-cwd-prefix"
                    },
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case"
                }
            },
        })

        telescope.load_extension("fzf")
        vim.keymap.set("n", "<leader>ff", builtin.find_files)
        vim.keymap.set("n", "<leader>fs", builtin.live_grep)
        vim.keymap.set("n", "<leader>fb", builtin.buffers)
        vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find)
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
        vim.keymap.set("n", "gd", builtin.lsp_definitions)
        vim.keymap.set("n", "gr", builtin.lsp_references)
        vim.keymap.set("n", "gi", builtin.lsp_implementations)
        vim.keymap.set("n", "<leader>gb", builtin.git_branches)
        vim.keymap.set("n", "<leader>gs", builtin.git_status)
        vim.keymap.set("n", "<leader>gc", builtin.git_commits)
        vim.keymap.set("n", "<leader>ft", builtin.treesitter)
    end
}
