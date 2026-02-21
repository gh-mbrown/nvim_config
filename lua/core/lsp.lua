local M = {}

M.capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local has_blink, blink_nvim_lsp = pcall(require, "blink.cmp")
	if has_blink then
		capabilities = vim.tbl_deep_extend("force", capabilities, blink_nvim_lsp.get_lsp_capabilities())
	end

	return capabilities
end

M.on_attach = function(_, _)
	-- VARIOUS COMMANDS
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover)
	vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help)
	vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
	vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition)

	-- WORKSPACE COMMANDS
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
	vim.keymap.set("n", "<leader>wf", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end)

	-- DIAGNOSTIC COMMANDS
	vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist)
	vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
end

M.setup = function()
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			show_header = true,
			source = "always",
			border = "rounded",
		},
	})

	vim.lsp.set_log_level("info")

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client then
				M.on_attach(client, args.buf)
			end
		end,
	})
end

return M
