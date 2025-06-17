local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        'bashls',
        'gopls',
        'lua_ls',
        'nil_ls',
        'pyright',
        'terraformls',
        'tsserver',
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup_handlers({
    function(server)
        lspconfig[server].setup({ capabilities = capabilities })
    end,
    gopls = function()
        lspconfig.gopls.setup({
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
    end,
    lua_ls = function()
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                        checkThirdParty = false,
                    },
                },
            },
        })
    end,
})

vim.diagnostic.config({
    virtual_lines = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = true },
})

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),
})
