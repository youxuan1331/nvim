-- 文件：lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",

  cmd  = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = { { "<C-b>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" } },

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    local nvim_tree = require("nvim-tree")
    local api       = require("nvim-tree.api")
    local telescope = require("telescope.builtin")
    local Path      = require("plenary.path")

    ---------------------------------------------------------------------------+
    -- 通用按键映射封装                                                      --
    ---------------------------------------------------------------------------+
    local function map(lhs, rhs, desc, bufnr)
      vim.keymap.set("n", lhs, rhs,
        { buffer = bufnr, noremap = true, silent = true, desc = desc })
    end

    ---------------------------------------------------------------------------+
    -- 根据光标所在节点生成 cwd                                              --
    ---------------------------------------------------------------------------+
    local function cwd_for_node()
      -- 新 API：api.tree.get_node_under_cursor()
      local node = api.tree.get_node_under_cursor()
      if not node then
        return vim.fn.getcwd()
      end

      local path = node.absolute_path
      if node.type ~= "directory" then
        path = Path:new(path):parent().filename
      end
      return path
    end

    ---------------------------------------------------------------------------+
    -- 自定义 on_attach（包含 telescope 集成功能）                            --
    ---------------------------------------------------------------------------+
    local function on_attach(bufnr)
      -- 现有默认行为
      map("l",     api.node.open.edit,             "Open / Expand", bufnr)
      map("h",     api.node.navigate.parent_close, "Close Dir",     bufnr)
      map("<CR>",  api.node.open.edit,             "Open File",     bufnr)

      -- ========== Telescope 集成 ==========
      -- 模糊文件搜索（默认 smart-case）
      map("sf", function()
        telescope.find_files({ cwd = cwd_for_node(), hidden = true })
      end, "Find Files (fuzzy)", bufnr)

      -- 模糊内容搜索（smart-case）
      map("sg", function()
        telescope.live_grep({ cwd = cwd_for_node() })
      end, "Live Grep (smart-case)", bufnr)

      -- 全词匹配
      map("sw", function()
        telescope.live_grep({
          cwd = cwd_for_node(),
          additional_args = function() return { "-w" } end,
        })
      end, "Live Grep (whole-word)", bufnr)

      -- 大小写严格匹配
      map("sc", function()
        telescope.live_grep({
          cwd       = cwd_for_node(),
          case_mode = "respect_case",
        })
      end, "Live Grep (case-sensitive)", bufnr)

      -- 忽略大小写匹配
      map("si", function()
        telescope.live_grep({
          cwd       = cwd_for_node(),
          case_mode = "ignore_case",
        })
      end, "Live Grep (ignore-case)", bufnr)
    end

    ---------------------------------------------------------------------------+
    -- nvim-tree 设置                                                         --
    ---------------------------------------------------------------------------+
    nvim_tree.setup({
      disable_netrw   = true,
      hijack_netrw    = true,
      respect_buf_cwd = true,
      update_cwd      = true,

      view = {
        width          = 35,
        relativenumber = true,
        signcolumn     = "yes",
      },

      renderer = {
        highlight_git          = true,
        highlight_opened_files = "name",
        root_folder_label      = false,
      },

      git       = { enable = true, ignore = false },
      filters   = { dotfiles = false, custom = { "^.git$" } },
      on_attach = on_attach,
    })
  end,
}

