vim.g.mapleader = " "

-- Misc
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
vim.keymap.set("n", "<leader>m", ":RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })

-- File explorer
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File explorer" })

-- File navigation (snacks picker)
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })

-- Git
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git status" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git log (file)" })
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git diff hunks" })
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git branches" })
vim.keymap.set({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git browse (GitHub)" })

-- Diffview
vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", { desc = "Diffview open" })
vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory %<CR>", { desc = "Diffview file history" })
vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Diffview close" })

-- LSP pickers (via snacks)
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Go to definition" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Go to implementation" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Go to type definition" })
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP symbols (file)" })
vim.keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP symbols (workspace)" })
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Diagnostics (buffer)" })

-- LSP actions (native, no picker needed)
vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format buffer" })
