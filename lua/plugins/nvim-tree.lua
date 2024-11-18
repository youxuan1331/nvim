return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            update_focused_file = {
                enable = true,     -- 启用聚焦功能
                update_cwd = true, -- 更新当前工作目录（可选）
                ignore_list = {}   -- 忽略的文件类型列表，可根据需要调整
              },
        }
    end,
}
