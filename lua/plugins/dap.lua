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
	config = function()
		vim.keymap.set("n", "<leader>db", function()
			vim.cmd.DapToggleBreakpoint()
		end)
		vim.keymap.set("n", "<leader>dc", function()
			vim.cmd.DapClearBreakpoints()
		end)
		vim.keymap.set("n", "<leader>de", function()
			vim.cmd.DapEval()
		end)
		vim.keymap.set("n", "<leader>ds", function()
			vim.cmd.DapShowLog()
		end)
		vim.keymap.set("n", "<leader>dr", function()
			vim.cmd.DapToggleRepl()
		end)
		vim.keymap.set("n", "<leader>dk", function()
			vim.cmd.DapTerminate()
		end)
		vim.keymap.set("n", "<leader>dn", function()
			vim.cmd.DapNew()
		end)
		vim.keymap.set("n", "<leader>dd", function()
			vim.cmd.DapDisconnect()
		end)
		vim.keymap.set("n", "<leader>dC", function()
			vim.cmd.DapContinue()
		end)
		vim.keymap.set("n", "<leader>di", function()
			vim.cmd.DapStepInto()
		end)
		vim.keymap.set("n", "<leader>do", function()
			vim.cmd.DapStepOver()
		end)
		vim.keymap.set("n", "<leader>dO", function()
			vim.cmd.DapStepOut()
		end)
		vim.keymap.set("n", "<leader>dp", function()
			vim.cmd.DapPause()
		end)
		vim.keymap.set("n", "<leader>dr", function()
			vim.cmd.DapRestartFrame()
		end)
	end,
}
