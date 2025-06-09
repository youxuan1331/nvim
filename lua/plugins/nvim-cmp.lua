-- lua/plugins/nvim-cmp.lua
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip", -- ✅ 确保 vsnip 本体也装了
    },
    config = function()
        local cmp = require 'cmp'
        local kind_icons = {
            Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
            Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
            Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎠",
            Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
            File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
            Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
            TypeParameter = "", Calc = "", Git = "",
            Search = "", Rime = "", Clipboard = "", Call = ""
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- ✅ 只留 vsnip
                end
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            formatting = {
                maxwidth = 150,
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "")
                    local source_names = {
                        nvim_lsp = "[LSP]",
                        vsnip = "[Vsnip]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                        cmdline = "[Cmd]",
                    }
                    vim_item.menu = source_names[entry.source.name] or ""
                    return vim_item
                end
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
                { name = 'buffer' },
                { name = 'path' },
            }),
        })

        -- 设置 cmdline 补全
        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'buffer' } }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline' }
            })
        })
    end
}

