return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = "Telescope",
  config = function()
    require("telescope").setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          preview_width = 0.6,
        },
        sorting_strategy = "descending",
      },
    })
  end,
}

