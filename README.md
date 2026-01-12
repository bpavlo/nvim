# Neovim Config

## Structure

```
init.lua
lua/
  settings.lua    -- editor options
  plugins.lua     -- lazy.nvim plugins
  mappings.lua    -- keybindings
  lsp.lua         -- LSP and completion
```

## Plugins

- black-metal-theme-neovim (colorscheme)
- nvim-treesitter
- telescope.nvim
- nvim-lspconfig (native completion)
- render-markdown.nvim
- undotree
- vim-fugitive
- which-key.nvim
- nvim-autopairs
- nvim-colorizer.lua

## LSP Servers (Nix)

bashls, gopls, lua_ls, nil_ls, pyright, terraformls

## Mappings

Leader: `<Space>`

| Key | Action |
|-----|--------|
| `<leader>n` | File explorer |
| `<leader>u` | Undotree |
| `<leader>gs` | Git status |
| `<leader>m` | Toggle markdown render |
| `<leader>ff` | Find files |
| `<leader>fg` | Grep |

### Completion (native)

| Key | Action |
|-----|--------|
| `<C-n>` | Next item |
| `<C-p>` | Previous item |
| `<C-y>` | Accept |
| `<C-e>` | Dismiss |

