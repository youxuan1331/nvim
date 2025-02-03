-- leader key 为空
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

local opt = {
  noremap = true,
  silent = true,
}

-- 本地变量
local map = vim.api.nvim_set_keymap


-- Telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

-- Nvim-tree
map("n", "<C-b>", ":NvimTreeToggle<CR>", opt)
map("i", "<C-b>", "<Esc>:NvimTreeToggle<CR>", opt)

function compile_and_run_cpp()
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local ext = filepath:match("^.+(%..+)$")  -- 获取文件扩展名

  if ext == '.cpp' then  -- 如果是C++文件
    local filename_without_ext = filepath:match("([^/]+)%.cpp$")
    local compile_command = "g++ " .. filepath .. " -o " .. filename_without_ext

    -- 编译
    local compile_result = vim.fn.system(compile_command)

    -- 输出编译结果
    if compile_result == "" then
      print("Compilation successful, executable is " .. filename_without_ext)

      -- 创建浮动窗口
      local width = vim.api.nvim_get_option("columns")
      local height = vim.api.nvim_get_option("lines")
      local win_height = math.ceil(height * 0.5)
      local win_width = math.ceil(width * 0.5)
      local row = math.ceil((height - win_height) / 2 - 1)
      local col = math.ceil((width - win_width) / 2)

      local buf = vim.api.nvim_create_buf(false, true)
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        row = row,
        col = col,
        width = win_width,
        height = win_height,
      })

      -- 关闭行号显示
      vim.api.nvim_win_set_option(win, 'number', false)
      vim.api.nvim_win_set_option(win, 'relativenumber', false)

      -- 在浮动窗口中运行程序
      vim.fn.termopen("./" .. filename_without_ext)

      -- 自动进入 Insert 模式
      vim.api.nvim_set_current_win(win)
      vim.cmd('startinsert')

      local close_window_mapping = string.format(
      [[<Cmd>lua vim.api.nvim_win_close(%d, true)<CR>]], win)
      vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', close_window_mapping, { noremap = true, silent = true })
    else
      print("Compilation failed: " .. compile_result)
    end
  else
    print("Not a C++ file.")
  end
end

-- 设置F5键用于编译和运行C++代码
map('n', '<F5>', [[<Cmd>lua compile_and_run_cpp()<CR>]], opt)
-- map('n', '<F5>', [[<Cmd>lua create_float_window()<CR>]], opt)
