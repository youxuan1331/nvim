-- 自动安装 / 管理 LSP & DAP 等可执行文件
return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd   = { "Mason", "MasonInstall", "MasonUninstall" },
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  config = function()
    -------------------------------------------------------------- mason本体
    require("mason").setup({
      ui = {
        border = "rounded",
        icons  = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
      max_concurrent_installers = 10,
    })

    --------------------------------------------------------- mason-lspconfig
    local mason_lsp = require("mason-lspconfig")

    mason_lsp.setup({
      ensure_installed = { "lua_ls", "clangd", "bashls", "jsonls", "yamlls", "cmake" },
      automatic_installation = true,
    })

    ------------------------------------------------------------- 公共参数
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp  = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp.default_capabilities(capabilities)
    end

    local function on_attach(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        client.server_capabilities.documentFormattingProvider = false
      end
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs,
          { buffer = bufnr, silent = true, desc = desc })
      end
      map("gd", vim.lsp.buf.definition,         "跳转定义")
      map("gr", vim.lsp.buf.references,         "引用")
      map("K",  vim.lsp.buf.hover,              "悬停")
      map("<leader>rn", vim.lsp.buf.rename,     "重命名")
      map("<leader>ca", vim.lsp.buf.code_action,"Code Action")
    end

    ------------------------------------------------------------- 兼容处理
    if mason_lsp.setup_handlers ~= nil then
      -- ★ 新 API：setup_handlers ★
      mason_lsp.setup_handlers({
        function(server)
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach    = on_attach,
          })
        end,
      })
    else
      -- ★ 旧 API：循环已安装服务器 ★
      for _, server in ipairs(mason_lsp.get_installed_servers()) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach    = on_attach,
        })
      end
    end
  end,
}

