-- 文件：lua/plugins/telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope    = require("telescope")
        local pickers      = require("telescope.pickers")
        local finders      = require("telescope.finders")
        local actions      = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local conf         = require("telescope.config").values

        telescope.setup({})

        local grep_modes = {
            { name = "Fuzzy (smart-case)", args = nil,      case_mode = "smart_case"   },
            { name = "Whole Word",         args = { "-w" }, case_mode = "smart_case"   },
            { name = "Case-Sensitive",     args = nil,      case_mode = "respect_case" },
            { name = "Ignore Case",        args = nil,      case_mode = "ignore_case"  },
        }

        vim.keymap.set("n", "<C-f>", function()
            pickers.new({}, {
                prompt_title = "Select grep modes (Tab 多选，Enter 确认)",
                finder = finders.new_table {
                    results = grep_modes,
                    entry_maker = function(entry)
                        return {
                            value   = entry,
                            display = entry.name,
                            ordinal = entry.name,
                        }
                    end,
                },
                sorter = conf.generic_sorter({}),

                attach_mappings = function(prompt_bufnr, map)
                    local function toggle_and_next()
                        actions.toggle_selection(prompt_bufnr)
                        actions.move_selection_next(prompt_bufnr)
                    end
                    map("i", "<Tab>", toggle_and_next)
                    map("n", "<Tab>", toggle_and_next)

                    actions.select_default:replace(function()
                        -- 获取当前 picker，然后拿多选列表
                        local picker = action_state.get_current_picker(prompt_bufnr)
                        local sels = picker:get_multi_selection()
                        if #sels == 0 then
                            -- 如果没多选，就单选当前行
                            sels = { action_state.get_selected_entry(prompt_bufnr) }
                        end
                        actions.close(prompt_bufnr)

                        -- 聚合参数
                        local arg_list = {}
                        local case_mode
                        for _, sel in ipairs(sels) do
                            if sel.value.args then
                                for _, a in ipairs(sel.value.args) do
                                    table.insert(arg_list, a)
                                end
                            end
                            case_mode = sel.value.case_mode
                        end

                        require("telescope.builtin").live_grep({
                            cwd             = vim.fn.getcwd(),
                            additional_args = (#arg_list > 0) and function() return arg_list end or nil,
                            case_mode       = case_mode,
                        })
                    end)

                    return true
                end,
            }):find()
        end, { desc = "Live Grep with multiple-mode selection" })
    end,
}

