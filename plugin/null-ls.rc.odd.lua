local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.beautysh,
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

vim.api.nvim_create_user_command("DisableFormatting", function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
end, { nargs = 0 })

vim.api.nvim_create_user_command("EnableFormatting", function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = function()
			lsp_formatting(bufnr)
		end,
	})
end, { nargs = 0 })

vim.api.nvim_create_user_command("FormatBuf", function()
	local bufnr = vim.api.nvim_get_current_buf()
	lsp_formatting(bufnr)
end, { nargs = 0 })

vim.keymap.set("n", "<M-S-f>", "<Cmd>FormatBuf<CR>")
