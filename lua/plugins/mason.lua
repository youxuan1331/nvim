return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            max_concurrent_installers = 10, -- 最大并发安装数
        })

        require("mason-lspconfig").setup({
            ensure_installed = {  -- 自动安装的 LSP 服务器
                "lua_ls",       -- Lua
                 --"bashls",       -- Bash
                 --"pyright",      -- Python
                "clangd",       -- C/C++
                 --"cmake",        -- CMake
                 --"jsonls",       -- JSON
                 --"yamlls",       -- YAML
            },
            automatic_installation = true, -- 启用自动安装
        })

        -- 启用每个 LSP 服务器
        local lspconfig = require("lspconfig")
        -- local servers = { "lua_ls", "bashls", "pyright", "clangd", "cmake", "jsonls", "yamlls" }
        local servers = { "clangd" }



        for _, server in ipairs(servers) do
            lspconfig[server].setup {}
        end
    end,
}
