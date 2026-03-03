return {
	"mfussenegger/nvim-dap",
	opts = function()
		local dap = require("dap")

		if not dap.adapters["codelldb"] then
			dap.adapters["codelldb"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = {
						"--port",
						"${port}",
					},
				},
			}
		end
		dap.configurations.cpp = {
			{
				type = "codelldb",
				request = "launch",
				name = "Launch file",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
			{
				type = "codelldb",
				request = "attach",
				name = "Attach to process",
				pid = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.c = {
			{
				type = "codelldb",
				request = "launch",
				name = "Launch file",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
			{
				type = "codelldb",
				request = "attach",
				name = "Attach to process",
				pid = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}
	end,
	config = function() end,
}
