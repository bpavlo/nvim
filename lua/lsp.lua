-- Server-specific configurations
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			analyses = {
				unusedparams = true,
				unreachable = true,
			},
			usePlaceholders = true,
			staticcheck = true,
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

-- Enable servers (must be in PATH via nix)
vim.lsp.enable({
	"bashls",
	"gopls",
	"lua_ls",
	"nil_ls",
	"pyright",
	"terraformls",
})

vim.diagnostic.config({
	virtual_lines = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = true },
})

-- Native completion (Neovim 0.11+)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
