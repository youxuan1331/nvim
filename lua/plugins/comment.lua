return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
            toggler = {
                line = '<C-_>', -- 普通模式下，Ctrl+/ 切换当前行注释
                block = 'gbc', -- 普通模式下，切换块注释（如有需要）
            },
            opleader = {
                line = '<C-_>', -- 操作符模式下，Ctrl+/ 作为注释操作符
                block = 'gb', -- 块注释操作符模式
            },
        })
    end,
}