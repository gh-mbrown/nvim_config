return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S . -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
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
					"_build",
					"bin",
					"out",
				},
				layout_strategy = "flex",
				layout_config = {
					flex = {
						flip_columns = 100,
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
					"filename_first",
				},
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"fd",
						"--type",
						"f",
						"--strip-cwd-prefix",
					},
					theme = "ivy",
					preview = false,
				},
				buffers = {
					theme = "ivy",
					preview = false,
				},
				help_tags = {
					theme = "ivy",
					preview = false,
				},
				git_branches = {
					theme = "ivy",
					preview = false,
				},
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

		vim.api.nvim_create_user_command("ProjectFiles", builtin.find_files, {})
		vim.api.nvim_create_user_command("ProjectGrep", builtin.live_grep, {})
		vim.api.nvim_create_user_command("ProjectBuffers", builtin.buffers, {})
		vim.api.nvim_create_user_command("ProjectHelp", builtin.help_tags, {})
		vim.api.nvim_create_user_command("GotoDefinition", builtin.lsp_definitions, {})
		vim.api.nvim_create_user_command("GotoReferences", builtin.lsp_references, {})
		vim.api.nvim_create_user_command("GotoImplementations", builtin.lsp_implementations, {})
		vim.api.nvim_create_user_command("ProjectGitBranch", builtin.git_branches, {})
		vim.api.nvim_create_user_command("ProjectTreesitter", builtin.treesitter, {})
		vim.api.nvim_create_user_command("SearchCommands", builtin.keymaps, {})
	end,
}
