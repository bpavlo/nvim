# Neovim Config

## Structure

```
init.lua
lua/
  settings.lua    -- editor options
  plugins.lua     -- lazy.nvim plugins
  mappings.lua    -- keybindings
  lsp.lua         -- LSP, completion, format-on-save
cheatsheets/
  keymaps.md      -- full keymap reference
  find-and-replace.md  -- :s and search patterns
```

## Plugins

- black-metal-theme-neovim (colorscheme)
- nvim-treesitter
- snacks.nvim (picker, explorer, lazygit, gitbrowse, notifier)
- gitsigns.nvim (hunk signs, staging, blame)
- diffview.nvim (side-by-side diff, file history)
- nvim-lspconfig (native completion, format-on-save)
- render-markdown.nvim
- undotree
- which-key.nvim
- nvim-autopairs
- nvim-colorizer.lua

## LSP Servers (via Nix)

bashls, gopls, lua_ls, nil_ls, pyright, terraformls, typst_lsp

## Quick Reference

Leader: `<Space>` — see `cheatsheets/keymaps.md` for the full reference.

### Completion (native, auto-triggered)

| Key | Action |
|-----|--------|
| `<C-n>` | Next item |
| `<C-p>` | Previous item |
| `<C-y>` | Accept |
| `<C-e>` | Dismiss |
