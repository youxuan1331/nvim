return {
  "stevearc/conform.nvim",
  event = "VeryLazy", -- ✅ 不绑定 BufWritePre，避免自动格式化
  config = function()
    local conform = require("conform")

    conform.setup({
      -- 🚫 不启用 format_on_save，完全取消保存自动格式化
      formatters = {
        clang_format = {
          command = "/usr/sbin/clang-format",
          args = {
            "--style=file",
            "--assume-filename",
            vim.fn.expand("~/.config/nvim/tools/dummy.cpp"), -- ✅ 指定 .clang-format 路径所在目录
          },
          stdin = true,
        },
      },
      formatters_by_ft = {
        cpp = { "clang_format" },
        c = { "clang_format" },
      },
    })

    -- ✅ 手动格式化：<leader>f
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      local notify = vim.notify

      local ok, err = pcall(function()
        conform.format({
          async = true,
          lsp_fallback = true,
          timeout_ms = 2000,
        })

        notify("✅ 格式化请求已发送", vim.log.levels.INFO, {
          title = "Conform",
          icon = "",
        })
      end)

      if not ok then
        notify("❌ 格式化失败:\n" .. err, vim.log.levels.ERROR, {
          title = "Conform Error",
          icon = "",
        })
      end
    end, { desc = "格式化代码" })
  end,
}

