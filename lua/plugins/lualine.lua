-- 文件：lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "Civitasv/cmake-tools.nvim",
  },
  event = "VeryLazy",

  config = function()
    -- ===== CMake 状态组件 =====
    local cmake  = require("cmake-tools")

    local function cmake_status_component()
      local st = cmake.status() or ""
      if st == "" then return "" end    -- 无配置 / 非 CMake 项目

      -- 高亮根据构建类型着色
      local color = {
        Debug   = { fg = "#7aa2f7" },   -- 蓝
        Release = { fg = "#f7768e" },   -- 红
        RelWithDebInfo = { fg = "#bb9af7" }, -- 紫
      }

      return {
        "🛠 " .. st,
        color = color[st] or {},
      }
    end

    -- ===== LSP 进度组件 =====
    local function lsp_progress_component()
      local msgs = vim.lsp.util.get_progress_messages()
      if #msgs == 0 then return "" end
      local msg = msgs[1]                  -- 取第一条即可
      local title = msg.title or msg.name or ""
      local percentage = msg.percentage and (msg.percentage .. "%%") or ""
      return string.format(" %s %s", title, percentage)
    end

    -- ===== 组装 Lualine =====
    require("lualine").setup({
      options = {
        theme                = "auto",
        icons_enabled        = true,
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = {
          statusline = { "lazy", "alpha", "NvimTree", "toggleterm" },
          winbar     = { "NvimTree", "toggleterm" },
        },
        always_divide_middle = true,
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
          cmake_status_component,
          lsp_progress_component,
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },

      extensions = { "nvim-tree", "toggleterm", "fugitive" },
    })
  end,
}

