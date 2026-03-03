local M = {}

M.capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local has_blink, blink_nvim_lsp = pcall(require, "blink.cmp")
	if has_blink then
		capabilities = vim.tbl_deep_extend("force", capabilities, blink_nvim_lsp.get_lsp_capabilities())
	end

	return capabilities
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
			_ = vim.lsp.get_client_by_id(args.data.client_id)
		end,
	})
end

return M
