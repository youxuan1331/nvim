return {
    "williamboman/mason.nvim",
    dependencies =  {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup({
            automatic_installation = true,
            -- 自动安装 Language Servers
            -- ensure_installed = {},
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },

            max_concurrent_installers = 10,
        })

        local lspconfig = require('lspconfig')

        local servers = {
            --"clangd",
            --"cmake",
            "lua_ls",
            --"ts_ls",
            --"tailwindcss",
            "bashls",
            --"cssls",
            --"dockerls",
            --"emmet_ls",
            --"html",
            --"jsonls",
            --"pyright",
            --"rust_analyzer",
            --"taplo",
            --"yamlls",
            --"vimls",
        }
--
        --require("mason-lspconfig").setup({
            ---- 确保安装，根据需要填写
            --ensure_installed = servers,
        --})
        --for _, server in ipairs(servers) do
            --lspconfig[server].setup {}
        --end
        ---- require("lspconfig").rust_analyzer.setup {}
        --require("lspconfig").clangd.setup {
          --on_new_config = function(new_config, root_dir)
            --if root_dir == "~/huawei/feature/1017/" then 
                --new_config.cmd = {"~/huawei/feature/1017/prebuilts/clang/ohos/linux-x86_64/llvm/bin/clangd", '--background-index', '--clang-tidy'}
                --new_config.cmd_args = {'--compile-commands-dir=~/huawei/feature/1017/out/rk3568/compile_commands.json'}
            --elseif root_dir == "~/huawei/openharmony/oh-master" then 
                --new_config.cmd = {"~/huawei/openharmony/oh-master/prebuilts/clang/ohos/linux-x86_64/llvm/bin/clangd", '--background-index', '--clang-tidy'}
                --new_config.cmd_args = {'--compile-commands-dir=~/huawei/openharmony/oh-master/out/rk3568/compile_commands.json'}
            --end
        --end,
        --}

    end,
}
