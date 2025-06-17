local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("module.plugins.colorizer")
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    config = function()
      require("module.plugins.solarized-osaka")
    end,
  },
  -- {
  --   "jameswalls/naysayer.nvim",
  --   config = function()
  --     require("module.plugins.naysayer")
  --   end,
  -- },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("module.plugins.telescope")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("module.plugins.treesitter")
    end,
  },
  "mbbill/undotree",
  "tpope/vim-fugitive",
  "folke/which-key.nvim",
  -- "mickael-menu/zk-nvim",
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
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
