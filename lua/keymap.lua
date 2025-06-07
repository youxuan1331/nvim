vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- Telescope -----------------------------------------------------------
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", opt)
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", opt)

-- nvim-tree -----------------------------------------------------------
map({ "n", "i" }, "<C-b>", "<cmd>NvimTreeToggle<CR>", opt)

-- bufferline ----------------------------------------------------------
map({ "n", "i" }, "tn", "<cmd>BufferLineCycleNext<CR>", opt)
map({ "n", "i" }, "tp", "<cmd>BufferLineCyclePrev<CR>", opt)

-- ---------- 编译并运行当前 C/C++ 文件 ---------- --------------------
local function compile_and_run_cpp()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then return end
  local ext  = file:match("^.+(%..+)$")
  local exe  = vim.fn.fnamemodify(file, ":r")
  local cmd
  if ext == ".cpp" or ext == ".cc" or ext == ".cxx" then
    cmd = string.format("clang++ %s -o %s -std=c++20 -O2", file, exe)
  elseif ext == ".c" then
    cmd = string.format("gcc %s -o %s -O2", file, exe)
  else
    vim.notify("Not a C/C++ file", vim.log.levels.WARN)
    return
  end
  local out = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("❌ 编译失败:\n" .. out, vim.log.levels.ERROR)
    return
  end
  -- 浮窗终端
  local buf = vim.api.nvim_create_buf(false, true)
  local w   = math.floor(vim.o.columns * 0.6)
  local h   = math.floor(vim.o.lines   * 0.6)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor", row = (vim.o.lines-h)/2, col = (vim.o.columns-w)/2,
    width = w, height = h, style = "minimal", border = "rounded",
  })
  vim.fn.termopen("./" .. exe)
  vim.cmd.startinsert()
  vim.keymap.set("t", "<Esc>", function() vim.api.nvim_win_close(win, true) end,
                 { buffer = buf, silent = true })
end

map({ "n", "i" }, "<F5>", compile_and_run_cpp, opt)

-- notify 关闭全部
map("n", "<leader>nn", function()
  require("notify").dismiss({ silent = true, pending = true })
end, opt)

