return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    vim.notify = require("notify")

    require("notify").setup({
      background_colour = "#000000",
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 1500,
    })
  end,
}

