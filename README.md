# Neovim 配置
这是一个[neovim](https://neovim.io/)配置文件的仓库，可以理解为一种新的vim，对neovim版本的要求是需要8以上
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
```
```bash
git clone git@github.com:youxuan1331/nvim.git ~/.config/nvim
```

然后把放到项目的根目录下的.init.lua，和vscode一样需要索引后才能跳转
```lua
-- .init.nvim

-- 获取项目根目录
local project_root = vim.fn.getcwd()
local home = vim.fn.expand('~')

-- 定义工具的路径
local clangd_path = project_root .. '/prebuilts/clang/ohos/linux-x86_64/llvm/bin/clangd'
local clang_path = project_root .. '/prebuilts/clang/ohos/linux-x86_64/llvm/bin/clang'
local clang_format_path = project_root .. '/prebuilts/clang/ohos/linux-x86_64/llvm/bin/clang-format'
local gn_path = project_root .. '/prebuilts/build-tools/linux-x86/bin/gn'
local compile_commands_dir = project_root .. '/out/rk3568'

-- 确保 lspconfig 已加载
local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then
  return
end

-- 配置 clangd
local clangd_cmd = {
  clangd_path,
  '--clang-tidy',
  '--compile-commands-dir=' .. compile_commands_dir,
  '--completion-style=bundled',
  '--enable-config',
  '--function-arg-placeholders=false',
  '--header-insertion-decorators',
  '--header-insertion=iwyu',
  '--log=verbose',
  '--pch-storage=memory',
  '--pretty',
  '--ranking-model=heuristics',
  '-j=24',
  '--query-driver=' .. clang_path
}

lspconfig.clangd.setup{
  cmd = clangd_cmd,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  root_dir = lspconfig.util.root_pattern('compile_commands.json', '.git'),
}
```

# Todo List
- [ ] 基础插件（有待完善）
- [x] 语法补全
- [x] 跳转
- [ ] cpp格式化
- [ ] build.gn格式化

# 已知问题
- 左侧文件目录不会像vscode一样根据打开的文件进行变化 (Fix)
- 代码跳转是跳转到头文件
- cpp格式化未完成
- build.gn格式化未完成