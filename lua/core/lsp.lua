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

	vim.lsp.log.set_level("info")
end

return M
