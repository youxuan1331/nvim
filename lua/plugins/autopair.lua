-- 自动补全括号 / 引号
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",

  dependencies = {
    "hrsh7th/nvim-cmp",   -- 与 cmp 联动（可选）
  },

  opts = {
    check_ts = true,      -- treesitter 语法感知
    fast_wrap = {},
  },

  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    -- 与 nvim-cmp 集成：确认补全后自动插入括号
    local ok_cmp, cmp = pcall(require, "cmp")
    if ok_cmp then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done",
        cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end
  end,
}

