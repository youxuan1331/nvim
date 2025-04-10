-- return {
--     "nvim-tree/nvim-tree.lua",
--     version = "*",
--     lazy = false,
--     dependencies = {
--         "nvim-tree/nvim-web-devicons",
--     },
--     config = function()
--         require("nvim-tree").setup {
--             update_focused_file = {
--                 enable = true,     -- 启用聚焦功能
--                 update_cwd = true, -- 更新当前工作目录（可选）
--                 ignore_list = {}   -- 忽略的文件类型列表，可根据需要调整
--               },
--         }
--     end,
-- }
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    })

    vim.keymap.set("n", "<leader>sf", function()
      local lib = require("nvim-tree.lib")
      local node = lib.get_node_at_cursor()
      if not node then return end

      local path = node.absolute_path
      if node.type ~= "directory" then
        path = vim.fn.fnamemodify(path, ":h")
      end

      require("telescope.builtin").live_grep({
        search_dirs = { path },
        prompt_title = "Live Grep in " .. path,
      })
    end, { desc = "Telescope: grep in selected folder" })
  end
}

