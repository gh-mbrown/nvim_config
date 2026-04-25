return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S . -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		"nvim-telescope/telescope-project.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local pa = require("telescope._extensions.project.actions")

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
				project = {
					theme = "ivy",
					mappings = {
						i = {
							["<C-c>"] = pa.add_project,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("project")
	end,
}
