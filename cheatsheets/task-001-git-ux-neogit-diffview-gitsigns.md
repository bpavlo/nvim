# Task 001 - Unified Git UX (Neogit + Diffview + Gitsigns)

## Goal
Replace `Snacks.lazygit` with `Neogit`, keep `Diffview` for commit/file history, and keep `Gitsigns` for line-level blame so Git actions feel like one consistent workflow.

## Why this split works
- **Neogit**: staging, committing, branch operations, and repo-level workflows
- **Diffview**: commit/file history and rich diff navigation
- **Gitsigns**: in-buffer hunk ops and line-level blame (`git blame` style)

`Diffview` is not a full inline blame replacement; `Gitsigns` should remain the source of truth for per-line authorship.

## Current state (from your config)
- `Snacks.lazygit` enabled in `lua/plugins.lua`
- `<leader>gg` mapped to lazygit in `lua/mappings.lua`
- `Diffview` already installed
- `Gitsigns` already installed with blame on `<leader>hb`

## Changes to make
1. In `lua/plugins.lua`, disable/remove the `Snacks` lazygit integration.
2. Add `Neogit` plugin with `Diffview` integration enabled.
3. In `lua/mappings.lua`, remap `<leader>gg` from `Snacks.lazygit()` to `Neogit` open.
4. Keep existing git picker maps (`<leader>gs`, `<leader>gl`, etc.) until you decide whether to fully consolidate under Neogit/Diffview.

## Suggested keymap convention
- `<leader>gg` -> open Neogit (main Git dashboard)
- `<leader>dv` -> DiffviewOpen (repo diff context)
- `<leader>dh` -> DiffviewFileHistory for current file
- `<leader>dc` -> DiffviewClose
- `<leader>hb` -> Gitsigns blame line (line-level authorship)
- `<leader>hp` -> Gitsigns preview hunk

This keeps a clear mental model:
- repo workflow = Neogit
- history/diffs = Diffview
- local line/hunk context = Gitsigns

## Validation checklist
- `:Lazy sync` installs Neogit cleanly
- `<leader>gg` opens Neogit
- `DiffviewOpen` works from keymap
- `<leader>hb` still shows blame for current line
- No broken references to `Snacks.lazygit`

## Follow-up (next task)
Track explorer behavior and terminal-mode navigation in a separate task file:
- startup explorer behavior for `nvim .`
- on-demand left sidebar explorer
- terminal-mode `Esc` and `<C-w>` ergonomics for `opencode.nvim` buffers
