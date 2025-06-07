-- lua/plugins/lualine.lua
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  event = 'VeryLazy',
  config = function()
    -- 如果你喜欢 Catppuccin / Tokyonight / gruvbox 等主题，都可以放在这里：
    -- local theme = 'catppuccin'
    -- local theme = 'tokyonight'
    local theme = 'auto'  -- 自动跟随当前 colorscheme

    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = theme,
        -- 分隔符样式，可根据喜好替换成其他符号
        component_separators = { left = '', right = '' },
        section_separators   = { left = '', right = '' },
        disabled_filetypes   = {
          winbar = { 'NvimTree', 'toggleterm' },
          statusline = { 'lazy', 'alpha', 'NvimTree', 'toggleterm' },
        },
        always_divide_middle = true,
      },
      sections = {
        -- 左侧：模式 + Git 分支 + diff + LSP/诊断
        lualine_a = { 'mode' },
        lualine_b = {
          { 'branch',        icon = '' },
          { 'diff',
            symbols = { added = ' ', modified = '柳', removed = ' ' },
          },
          { 'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
          },
        },
        -- 中间：当前文件名 + 代码进度（百分比）
        lualine_c = {
          { 'filename',
            file_status = true,  -- 未保存 + 只读标记
            path = 1,            -- 相对路径
          },
        },
        -- 右侧：encoding + 文件格式 + filetype + 当前行列
        lualine_x = {
          'encoding',
          'fileformat',
          { 'filetype', icon_only = false },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        -- 窗口不活动时简化显示
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {
        'nvim-tree',
        'toggleterm',
        'fugitive',
      },
    })
  end,
}

