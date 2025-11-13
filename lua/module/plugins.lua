local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("module.plugins.colorizer")
		end,
	},
--	{
--		"craftzdog/solarized-osaka.nvim",
--		config = function()
--			require("module.plugins.solarized-osaka")
--		end,
--	},
--  {
--  "https://git.kyren.codes/Kyren223/carbonight.nvim",
--  lazy = false, -- load immediately
--  priority = 1000, -- make sure it loads before other plugins
--  config = function()
--    vim.cmd.colorscheme("carbonight")
--  end,
--  },
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("black-metal").setup({})
      require("black-metal").load("mayhem")
    end,
  },
--  {
--      "zenbones-theme/zenbones.nvim",
--      -- Optionally install Lush. Allows for more configuration or extending the colorscheme
--      -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
--      -- In Vim, compat mode is turned on as Lush only works in Neovim.
--    --dependencies = "rktjmp/lush.nvim",
--      lazy = false,
--      priority = 1000,
--      -- you can set set configuration options here
--       config = function()
--           vim.g.zenbones_darken_comments = 45
--           vim.g.zenbones_compat = 1
--      --     vim.cmd.colorscheme('zenbones')
--      end,
--  },
--  { "kepano/flexoki-neovim", name = "flexoki",
--    config = function()
--      require("module.plugins.flexoki")
--    end,
--  },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("module.plugins.telescope")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("module.plugins.treesitter")
		end,
	},
	"mbbill/undotree",
	"tpope/vim-fugitive",
	"folke/which-key.nvim",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("module.plugins.lsp")
		end,
	},
})
