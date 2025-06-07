-- 文件浏览器
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",

  cmd  = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = { { "<C-b>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" } },

  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local nvim_tree = require("nvim-tree")

    ---------------------------------------------------------------- on_attach
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs,
          { buffer = bufnr, noremap = true, silent = true, desc = desc })
      end

      map("l",     api.node.open.edit,                 "打开 / 展开")
      map("h",     api.node.navigate.parent_close,     "关闭目录")
      map("<CR>",  api.node.open.edit,                 "打开")
      map("a",     api.fs.create,                      "新建")
      map("d",     api.fs.remove,                      "删除")
      map("r",     api.fs.rename,                      "重命名")
      map("gy",    api.fs.copy.relative_path,          "复制相对路径")
    end

    ---------------------------------------------------------------- setup
    nvim_tree.setup({
      disable_netrw       = true,
      hijack_netrw        = true,
      respect_buf_cwd     = true,
      update_cwd          = true,

      view = {
        width            = 35,
        relativenumber   = true,
        signcolumn       = "yes",
      },

      renderer = {
        highlight_git         = true,
        highlight_opened_files = "name",
        root_folder_label      = false,
        icons = {
          show = {
            file          = true,
            folder        = true,
            folder_arrow  = true,
            git           = true,
          },
        },
      },

      git = {
        enable = true,
        ignore = false,
      },

      actions = {
        open_file = {
          resize_window = true,
        },
      },

      filters = {
        dotfiles = false,
        custom   = { "^.git$" },
      },

      on_attach = my_on_attach,
    })
  end,
}

