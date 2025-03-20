return {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end
          -- 快速跳转到上/下一个 Git 修改块
          map('n', ']c', gs.next_hunk, 'Next Hunk')
          map('n', '[c', gs.prev_hunk, 'Previous Hunk')
          -- 对修改块进行操作
          map('n', '<leader>hs', gs.stage_hunk, 'Stage Hunk')
          map('n', '<leader>hr', gs.reset_hunk, 'Reset Hunk')
          map('v', '<leader>hs', function()
            gs.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
          end, 'Stage Hunk')
          map('v', '<leader>hr', function()
            gs.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
          end, 'Reset Hunk')
          map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
          map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')
          map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
          map('n', '<leader>hp', gs.preview_hunk, 'Preview Hunk')
          map('n', '<leader>hb', gs.blame_line, 'Blame')
        end,
      })
    end,
  }
  