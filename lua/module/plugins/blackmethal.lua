return {
  "metalelf0/black-metal-theme-neovim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- The theme has several styles. You can choose one desired style here.
    -- Available styles are: "black-metal", "bathory", "dark-funeral", "gorgoroth", "mayhem", "scythe"
    vim.cmd.colorscheme("bathory")

    -- You can configure highlights by doing something like:
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
  end,
}
