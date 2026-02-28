# Keymap Cheatsheet

Leader: `<Space>`

---

## File Navigation

| Key | Action |
|-----|--------|
| `<leader>e` | File explorer (tree) |
| `<leader>ff` | Find files (cwd) |
| `<leader>fg` | Live grep |
| `<leader>fr` | Recent files |
| `<leader>fp` | Projects — switch root directory |
| `<leader>fb` | Open buffers |

---

## Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit (full TUI float) |
| `<leader>gs` | Git status picker |
| `<leader>gl` | Git log (all commits) |
| `<leader>gf` | Git log (current file) |
| `<leader>gd` | Git diff hunks picker |
| `<leader>gb` | Git branches |
| `<leader>gB` | Open current file/line in GitHub |

### Diffview

| Key | Action |
|-----|--------|
| `<leader>dv` | Open diffview (all changed files) |
| `<leader>dh` | File history (current file) |
| `<leader>dc` | Close diffview |

### Gitsigns (hunk-level, buffer-local)

| Key | Action |
|-----|--------|
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk inline |
| `<leader>hb` | Blame line (full commit info) |
| `<leader>hd` | Diff this file |

---

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition (picker) |
| `gD` | Go to declaration |
| `gr` | References (picker) |
| `gI` | Go to implementation (picker) |
| `gy` | Go to type definition (picker) |
| `K` | Hover docs |
| `grn` | Rename symbol (project-wide) |
| `gra` | Code action |
| `<leader>ss` | LSP symbols in file |
| `<leader>sS` | LSP symbols in workspace |
| `<leader>sd` | All diagnostics (picker) |
| `<leader>sD` | Buffer diagnostics (picker) |
| `<leader>lf` | Format buffer (manual) |
| `[d` / `]d` | Previous / next diagnostic |

> Format-on-save is automatic when an LSP with formatting support is attached.

---

## Completion (native, auto-triggered)

| Key | Action |
|-----|--------|
| `<C-n>` | Next item |
| `<C-p>` | Previous item |
| `<C-y>` | Accept |
| `<C-e>` | Dismiss |

---

## Misc

| Key | Action |
|-----|--------|
| `<leader>u` | Undotree |
| `<leader>m` | Toggle markdown render |

---

## Tips

- `which-key` is installed — press `<leader>` and wait to see available keymaps.
- `grn` (LSP rename) is smarter than find/replace — it's symbol-aware and works across the project.
- `cgn` + `.` is the fastest way to rename occurrences one-by-one with confirmation.
  See `find-and-replace.md` for details.
