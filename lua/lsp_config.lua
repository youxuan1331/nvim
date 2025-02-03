local on_attach = function(client, bufnr)
    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr
    }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gY', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gz', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- 其他 LSP 快捷键……
end

local lspconfig = require('lspconfig')
lspconfig.clangd.setup {
    on_attach = on_attach
    -- 其他配置项……
}
