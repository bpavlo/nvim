require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"go",
		"hcl",
		"java",
		"javascript",
		"lua",
		"markdown",
		"python",
		"rust",
		"typescript",
		"elixir",
	},

	ignore_install = {},

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
})
