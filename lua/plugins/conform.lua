return {
  "stevearc/conform.nvim",
  -- 不绑定 BufWritePre，避免任何自动格式化
  event = "VeryLazy",
  config = function()
    local conform = require("conform")

    conform.setup({
      -- 明确关闭保存时自动格式化
      format_on_save = false,
      -- 定义 clang-format
      formatters = {
        clang_format = {
          command = "/usr/sbin/clang-format",
          args = {
            -- 使用项目根目录下的 .clang-format
            "--style=file",
            -- 让 clang-format 根据当前文件名推断语言和风格
            "--assume-filename=${INPUT}",
          },
          stdin = true,
        },
      },
      -- 按文件类型指定 formatter
      formatters_by_ft = {
        c   = { "clang_format" },
        cpp = { "clang_format" },
      },
    })

    -- 手动格式化：<leader>f
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      local ok, err = pcall(function()
        conform.format({
          async       = true,
          lsp_fallback = true,
          timeout_ms  = 2000,
        })
      end)
      if ok then
        vim.notify("✅ 格式化已完成", vim.log.levels.INFO, {
          title = "Conform",
          icon  = "",
        })
      else
        vim.notify("❌ 格式化失败: " .. err, vim.log.levels.ERROR, {
          title = "Conform Error",
          icon  = "",
        })
      end
    end, { desc = "格式化代码" })
  end,
}

