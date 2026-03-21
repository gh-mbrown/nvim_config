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
		local actions = require("telescope.actions")
		local pa = require("telescope._extensions.project.actions")
		local theme = {
			theme = "ivy",
		}

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"%__virtual.cs$",
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
				},
				buffers = theme,
				help_tags = theme,
				git_branches = theme,
				treesitter = theme,
				keymaps = theme,
				commands = theme,
				live_grep = theme,
				diagnostics = theme,
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
