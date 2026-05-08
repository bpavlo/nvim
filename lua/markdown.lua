local M = {}

local HARD_WRAP_WIDTH = 80

local function set_buffer_options()
	local bo = vim.opt_local
	bo.wrap = true
	bo.linebreak = true
	bo.breakindent = true
	bo.showbreak = "↪ "
	bo.textwidth = 0
	bo.wrapmargin = 0
	bo.colorcolumn = ""
	bo.spell = true
	bo.spelllang = { "en_us", "ru", "uk", "fr" }
	bo.conceallevel = 2
	bo.formatoptions:remove("t")
	bo.formatoptions:remove("c")
	bo.formatoptions:remove("r")
	bo.formatoptions:remove("o")
	bo.formatoptions:append("j")
	bo.formatoptions:append("q")
	bo.formatoptions:append("n")
	bo.formatoptions:append("l")
end

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true, desc = desc })
end

local function set_visual_line_motions()
	for _, lhs in ipairs({ "j", "k", "0", "$", "^" }) do
		map({ "n", "x" }, lhs, "g" .. lhs, "Visual-line " .. lhs)
	end
end

function M.toggle_hard_wrap()
	if vim.bo.textwidth == 0 then
		vim.bo.textwidth = HARD_WRAP_WIDTH
		vim.opt_local.formatoptions:append("t")
		vim.notify("Markdown: hard-wrap ON at " .. HARD_WRAP_WIDTH, vim.log.levels.INFO)
	else
		vim.bo.textwidth = 0
		vim.opt_local.formatoptions:remove("t")
		vim.notify("Markdown: hard-wrap OFF", vim.log.levels.INFO)
	end
end

function M.hard_wrap_paragraph()
	local restore_tw = vim.bo.textwidth
	if restore_tw == 0 then
		vim.bo.textwidth = HARD_WRAP_WIDTH
	end
	vim.cmd("normal! gqap")
	vim.bo.textwidth = restore_tw
end

local function paragraph_range(start_line, end_line)
	local total = vim.api.nvim_buf_line_count(0)
	start_line = math.max(1, start_line)
	end_line = math.min(total, end_line)
	return start_line, end_line
end

local function current_paragraph_range()
	local cur = vim.api.nvim_win_get_cursor(0)[1]
	local total = vim.api.nvim_buf_line_count(0)
	local function blank(lnum)
		local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
		return line == nil or line:match("^%s*$") ~= nil
	end
	if blank(cur) then
		return cur, cur
	end
	local s = cur
	while s > 1 and not blank(s - 1) do
		s = s - 1
	end
	local e = cur
	while e < total and not blank(e + 1) do
		e = e + 1
	end
	return s, e
end

local function flow_lines(lines)
	local paragraphs = {}
	local current = {}
	for _, line in ipairs(lines) do
		if line:match("^%s*$") then
			if #current > 0 then
				table.insert(paragraphs, current)
				current = {}
			end
			table.insert(paragraphs, false)
		else
			table.insert(current, line)
		end
	end
	if #current > 0 then
		table.insert(paragraphs, current)
	end

	local out = {}
	local last_was_blank = false
	for _, p in ipairs(paragraphs) do
		if p == false then
			if not last_was_blank and #out > 0 then
				table.insert(out, "")
				last_was_blank = true
			end
		else
			local joined = table.concat(p, " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
			table.insert(out, joined)
			last_was_blank = false
		end
	end
	while #out > 0 and out[#out] == "" do
		table.remove(out, #out)
	end
	return out
end

function M.join_paragraph()
	local s, e = current_paragraph_range()
	if s == e then
		local line = vim.api.nvim_buf_get_lines(0, s - 1, s, false)[1] or ""
		if line:match("^%s*$") then
			return
		end
	end
	local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
	local flowed = flow_lines(lines)
	vim.api.nvim_buf_set_lines(0, s - 1, e, false, flowed)
end

function M.yank_flowed(visual)
	local lines
	if visual then
		local s = vim.fn.getpos("'<")[2]
		local e = vim.fn.getpos("'>")[2]
		s, e = paragraph_range(s, e)
		lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
	else
		local s, e = current_paragraph_range()
		lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
	end
	local flowed = flow_lines(lines)
	local text = table.concat(flowed, "\n")
	vim.fn.setreg("+", text)
	vim.fn.setreg('"', text)
	local n = #flowed
	vim.notify("Yanked " .. n .. (n == 1 and " line" or " lines") .. " (flowed) to clipboard", vim.log.levels.INFO)
end

local function set_keymaps()
	map("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", "Markdown: toggle render")
	map("n", "<leader>mw", M.toggle_hard_wrap, "Markdown: toggle hard wrap")
	map("n", "<leader>mq", M.hard_wrap_paragraph, "Markdown: hard-wrap paragraph")
	map("n", "<leader>mj", M.join_paragraph, "Markdown: join paragraph to one line")
	map("n", "<leader>my", function()
		M.yank_flowed(false)
	end, "Markdown: yank paragraph flowed")
	map("x", "<leader>my", function()
		vim.cmd('noautocmd normal! "vy')
		M.yank_flowed(true)
	end, "Markdown: yank selection flowed")
end

local group = vim.api.nvim_create_augroup("UserMarkdown", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "markdown" },
	callback = function()
		set_buffer_options()
		set_visual_line_motions()
		set_keymaps()
	end,
})

return M
