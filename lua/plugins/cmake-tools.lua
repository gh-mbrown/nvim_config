return {
	"Civitasv/cmake-tools.nvim",
	lazy = true,
	init = function()
		local loaded = false
		local function check()
			local cwd = vim.uv.cwd()

			if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
				require("lazy").load({
					plugins = {
						"cmake-tools.nvim",
					},
				})
				loaded = true
			end
		end
		check()
		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				if not loaded then
					check()
				end
			end,
		})

		vim.keymap.set("n", "<leader>cb", function()
			vim.cmd.CMakeBuild()
		end)
		vim.keymap.set("n", "<leader>cr", function()
			vim.cmd.CMakeRun()
		end)
		vim.keymap.set("n", "<leader>cg", function()
			vim.cmd.CMakeGenerate()
		end)
		vim.keymap.set("n", "<leader>cd", function()
			vim.cmd.CMakeDebug()
		end)
	end,
	opts = {},
}
