return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			highlight_overrides = {
				all = function(colors)
					return {
						WinSeparator = {
							fg = colors.pink,
						},
					}
				end,
			},
			flavour = "mocha",
			transparent_background = true,
			float = {
				solid = true,
			},
			term_colors = false,
			default_integrations = false,
			auto_integrations = true,
			integrations = {
				blink_cmp = {
					style = "bordered",
				},
				harpoon = true,
				hop = true,
				mason = true,
				telescope = {
					enabled = true,
				},
				which_key = true,
				lualine = {
					all = function(colors)
						---@type CtpIntegrationLualineOverride
						return {
							normal = {
								c = { bg = colors.surface0 },
							},
						}
					end,
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-nvim")
	end,
}
