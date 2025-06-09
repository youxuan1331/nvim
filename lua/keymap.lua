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

-- notify 关闭全部
map("n", "<leader>nn", function()
  require("notify").dismiss({ silent = true, pending = true })
end, opt)

