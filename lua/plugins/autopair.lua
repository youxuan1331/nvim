return {{
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- 仅在进入插入模式时加载，提高启动速度
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true, -- 开启 treesitter 检查（可提高括号判断准确率）
            map_cr = true, -- 启用 <CR> 映射，按回车时自动处理括号换行和缩进
            -- 可选配置，根据需求调整：
            fast_wrap = {}
        })

        -- 如果你同时在使用 nvim-cmp 进行补全，还可以集成 autopairs 和 cmp（非必须）：
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
}}