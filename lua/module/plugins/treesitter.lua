require("nvim-treesitter.config").setup({
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
    "jsdoc",

	},


	sync_install = false,

	auto_install = true,
  indent = {
    enable  = true
  },

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = { "markdown" },
	},
})
