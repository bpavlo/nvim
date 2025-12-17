local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Apply default capabilities to all servers
vim.lsp.config("*", { capabilities = capabilities })

-- Server-specific configurations
vim.lsp.config("gopls", {
	capabilities = capabilities,
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
	capabilities = capabilities,
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

-- Enable servers (must be in PATH via nix/homebrew)
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

-- Completion
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
	}),
})
