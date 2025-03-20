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

-- bufferline
map("n", "tn", ":BufferLineCycleNext<CR>", opt)
map("n", "tp", ":BufferLineCyclePrev<CR>", opt)
map("i", "tn", "<Esc>:BufferLineCycleNext<CR>", opt)
map("i", "tp", "<Esc>:BufferLineCyclePrev<CR>", opt)

-- 辅助函数：创建一个浮动窗口，并在窗口中显示指定内容
local function open_floating_window(content, title)
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")
    local win_height = math.ceil(height * 0.5)
    local win_width = math.ceil(width * 0.5)
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    -- 将内容按行写入 buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        row = row,
        col = col,
        width = win_width,
        height = win_height,
        style = "minimal",
        border = "rounded",
    })

    -- 关闭行号显示
    vim.api.nvim_win_set_option(win, 'number', false)
    vim.api.nvim_win_set_option(win, 'relativenumber', false)

    -- 设置 <Esc> 快捷键，退出时关闭窗口
    local close_window_mapping = string.format(
        [[<Cmd>lua vim.api.nvim_win_close(%d, true)<CR>]], win)
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', close_window_mapping, { noremap = true, silent = true })

    return win
end

-- 编译并运行 C/C++ 文件的函数
function compile_and_run_cpp()
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    local ext = filepath:match("^.+(%..+)$")  -- 获取文件扩展名

    if ext == '.cpp' then  -- 仅对 C++ 文件生效
        local filename_without_ext = filepath:match("([^/]+)%.cpp$")
        local compile_command = "clang " .. filepath .. " -o " .. filename_without_ext .. " -lstdc++"

        -- 执行编译命令
        local compile_result = vim.fn.system(compile_command)

        if vim.v.shell_error == 0 then
            -- 编译成功
            local success_message = "Compilation successful, executable is " .. filename_without_ext .. "\n\nRunning executable..."
            print(success_message)

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
                style = "minimal",
                border = "rounded",
            })

            vim.api.nvim_win_set_option(win, 'number', false)
            vim.api.nvim_win_set_option(win, 'relativenumber', false)

            -- 在浮动窗口中启动终端，并运行生成的可执行文件
            vim.fn.termopen("./" .. filename_without_ext)
            vim.api.nvim_set_current_win(win)
            vim.cmd('startinsert')

            local close_window_mapping = string.format(
                [[<Cmd>lua vim.api.nvim_win_close(%d, true)<CR>]], win)
            vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', close_window_mapping, { noremap = true, silent = true })
        else
            -- 编译失败，显示错误信息
            local error_message = "Compilation failed:\n" .. compile_result
            open_floating_window(error_message, "Compile Error")
        end

    elseif ext == '.c' then  -- 仅对 C 文件生效
        local filename_without_ext = filepath:match("([^/]+)%.c$")
        local compile_command = "gcc " .. filepath .. " -o " .. filename_without_ext

        -- 执行编译命令
        local compile_result = vim.fn.system(compile_command)

        if vim.v.shell_error == 0 then
            -- 编译成功
            local success_message = "Compilation successful, executable is " .. filename_without_ext .. "\n\nRunning executable..."
            print(success_message)

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
                style = "minimal",
                border = "rounded",
            })

            vim.api.nvim_win_set_option(win, 'number', false)
            vim.api.nvim_win_set_option(win, 'relativenumber', false)

            -- 在浮动窗口中启动终端，并运行生成的可执行文件
            vim.fn.termopen("./" .. filename_without_ext)
            vim.api.nvim_set_current_win(win)
            vim.cmd('startinsert')

            local close_window_mapping = string.format(
                [[<Cmd>lua vim.api.nvim_win_close(%d, true)<CR>]], win)
            vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', close_window_mapping, { noremap = true, silent = true })
        else
            -- 编译失败，显示错误信息
            local error_message = "Compilation failed:\n" .. compile_result
            open_floating_window(error_message, "Compile Error")
        end
    else
        print("Not a C/C++ file.")
    end
end

-- F5 键映射：用于编译并运行 C/C++ 文件
map('n', '<F5>', [[<Cmd>lua compile_and_run_cpp()<CR>]], opt)
map('i', '<F5>', [[<Cmd>lua compile_and_run_cpp()<CR>]], opt)
