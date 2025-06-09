-- utf-8 编码 -----------------------------------------------------------
vim.g.encoding      = "utf-8"       -- UI 字符集
vim.opt.fileencoding = "utf-8"      -- 写入文件时

-- 显示 / UI -----------------------------------------------------------
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.signcolumn     = "yes"
vim.opt.colorcolumn    = "80"
vim.opt.termguicolors  = true
vim.opt.background     = "dark"

-- Split & 滚动
vim.opt.splitbelow   = true
vim.opt.splitright   = true
vim.opt.scrolloff    = 8
vim.opt.sidescrolloff = 8

-- Tab / 缩进 -----------------------------------------------------------
vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = 4
vim.opt.expandtab   = true
vim.opt.smartindent = true

-- 搜索 ---------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.hlsearch   = false
vim.opt.incsearch  = true

-- 状态行 / 命令行 -----------------------------------------------------
vim.opt.cmdheight = 2
vim.opt.showmode  = false
vim.opt.pumheight = 10
vim.opt.showtabline = 2
vim.opt.wildmenu  = true
vim.opt.shortmess:append("c")  -- 消除 “match 123 of 456” 烦人信息 :contentReference[oaicite:0]{index=0}

-- 文件 / 缓冲区 -------------------------------------------------------
vim.opt.hidden      = true
vim.opt.swapfile    = false
vim.opt.backup      = false
vim.opt.writebackup = false
vim.opt.autoread    = true

-- 性能 / 交互 ---------------------------------------------------------
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.mouse      = "a"
vim.opt.clipboard:append("unnamedplus")

-- 允许 <Left>/<Right> 在行首尾换行
vim.opt.whichwrap  = "<,>,[,]"

-- 让 |ins-completion| 淘汰消息保持安静
--（上面 shortmess:append('c') 已解决）

-- 支持鼠标
vim.opt.mouse = "a"            -- 支持鼠标点击、选择、滚动
vim.opt.mousemoveevent = true  -- 允许拖拽 resize 窗口
vim.opt.mousemodel = "extend"  -- 鼠标右键进入 Visual 模式


