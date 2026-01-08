vim.g.mapleader = " "

vim.keymap.set("n", "<leader>n", ":Lexplore<CR>")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Render Markdown
vim.keymap.set("n", "<leader>m", ":RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })

-- Avante
vim.keymap.set("n", "<leader>ag", ":AvanteSwitchProvider gemini-cli<CR>", { desc = "Switch to Gemini" })
vim.keymap.set("n", "<leader>ac", ":AvanteSwitchProvider claude-code<CR>", { desc = "Switch to Claude" })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", function()
	builtin.grep_string({ search = vim.fn.input("rg > ") })
end)
