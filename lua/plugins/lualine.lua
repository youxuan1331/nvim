return {
    "nvim-lualine/lualine.nvim",

    config = function()
        local function lsp_progress()
            local messages = vim.lsp.status()
            if #messages == 0 then
                return ""
            end

            -- 这里以第一个消息为例，如果需要可以添加过滤条件
            local msg = messages[1]
            local percentage = msg.percentage or 0
            return string.format("%s: %d%%", msg.title or "Working", percentage)
        end

        require('lualine').setup({
            sections = {
                -- 在 lualine_c 中添加自定义组件
                lualine_c = { lsp_progress },
                -- 你可以保留其他 section 配置或合并到默认配置中
            },
            -- 其他配置项……
        })
        -- require('lualine').setup()
    end,
}
