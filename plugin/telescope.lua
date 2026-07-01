require("lazy_load").on_vim_enter(function()
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(ev)
            local name, kind = ev.data.spec.name, ev.data.kind
            if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
                if not ev.data.active then vim.cmd.packadd("telescope-fzf-native.nvim") end
                vim.system({ "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" }, { cwd = ev.data.path }):wait()
                vim.system({ "cmake", "--build", "build", "--config", "Release", "--target", "install" },
                    { cwd = ev.data.path }):wait()
            end
        end
    })

    vim.pack.add({
        { src = GIT_ROOT .. "nvim-telescope/telescope-project.nvim" },
        { src = GIT_ROOT .. "nvim-lua/plenary.nvim" },
        { src = GIT_ROOT .. "nvim-telescope/telescope-fzf-native.nvim" },
        { src = GIT_ROOT .. "nvim-telescope/telescope.nvim" }
    })

    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    telescope.setup({
        defaults = {
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = {
                    prompt_position = "top"
                }
            },
            path_display = {
                "filename_first"
            },
            mappings = {
                i = {
                    ["<Esc>"] = actions.close
                }
            }
        },
        pickers = {
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            },
        }
    })
    telescope.load_extension("fzf")
    telescope.load_extension("project")
    if pcall(require, "harpoon") then
        telescope.load_extension("harpoon")
        vim.keymap.set("n", "<leader>hh", telescope.extensions.harpoon.marks)
    end
    vim.keymap.set("n", "<leader>pp", telescope.extensions.project.project)
    vim.keymap.set("n", "<leader>pf", builtin.git_files)
    vim.keymap.set("n", "<leader>ff", builtin.find_files)
    vim.keymap.set("n", "<leader>pg", builtin.live_grep)
    vim.keymap.set("v", "<leader>pg", builtin.grep_string)
    vim.keymap.set("n", "<leader>pb", builtin.buffers)
    vim.keymap.set("n", "<leader>ph", builtin.help_tags)
    vim.keymap.set("n", "<leader>ch", builtin.command_history)
    vim.keymap.set("n", "<leader>pm", builtin.man_pages)
    vim.keymap.set("n", "gd", builtin.lsp_definitions)
    vim.keymap.set("n", "gr", builtin.lsp_references)
    vim.keymap.set("n", "gi", builtin.lsp_implementations)
    vim.keymap.set("n", "gt", builtin.lsp_type_definitions)
    vim.keymap.set("n", "<leader>pd", builtin.diagnostics)
    vim.keymap.set("n", "<leader>pt", builtin.treesitter)
end)
