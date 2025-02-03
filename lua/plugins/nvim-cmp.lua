return {
    "hrsh7th/nvim-cmp",

    dependencies = {"neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
                    "hrsh7th/cmp-cmdline", "hrsh7th/cmp-vsnip"},

    config = function()
        local cmp = require 'cmp'
        local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
            Calc = "",
            Git = "",
            Search = "",
            Rime = "",
            Clipboard = "",
            Call = ""
        }

        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end
            },
            window = {
                completion = cmp.config.window.bordered(), -- 不指定 width 参数
                documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true
                        })
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({
                    select = true
                }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            formatting = {
                maxwidth = 150,
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "")
                    -- 可以根据补全来源显示不同的标识
                    if entry.completion_item.detail and #entry.completion_item.detail > 0 then
                        vim_item.menu = entry.completion_item.detail
                    else
                        local source_names = {
                            nvim_lsp   = "[LSP]",
                            vsnip      = "[Vsnip]",
                            luasnip    = "[LuaSnip]",
                            ultisnips  = "[UltiSnips]",
                            snippy     = "[Snippy]",
                            buffer     = "[Buffer]",
                            path       = "[Path]",
                            cmdline    = "[Cmd]",
                        }
                        vim_item.menu = source_names[entry.source.name] or ""
                    end
                    -- vim_item.menu = source_names[entry.source.name] or ""
                    return vim_item
                end
            },
            sources = cmp.config.sources({{
                name = 'nvim_lsp'
            }, {
                name = 'vsnip'
            }, -- For vsnip users.
            {
                name = 'luasnip'
            }, -- For luasnip users.
            {
                name = 'ultisnips'
            }, -- For ultisnips users.
            {
                name = 'snippy'
            } -- For snippy users.
            }, {{
                name = 'buffer'
            }}),
            vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({{
                name = 'git'
            } -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {{
                name = 'buffer'
            }})
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{
                name = 'buffer'
            }}
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({{
                name = 'path'
            }}, {{
                name = 'cmdline'
            }})
        })

    end
}
