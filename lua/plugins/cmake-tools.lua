-- lua/plugins/cmake-tools.lua
return {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        -- CMake 可执行文件路径（如果系统 PATH 已经有，就不用改）
        cmake_command                = "cmake",
        ctest_command                = "ctest",
        -- 是否使用 CMakePresets.json / CMakeUserPresets.json
        cmake_use_preset             = true,
        -- 保存 CMakeLists.txt 时自动重新生成
        cmake_regenerate_on_save     = true,
        -- 传给 `cmake --build` 的额外参数
        cmake_build_options          = { "--parallel" },
        -- 传给 `cmake --install` 的额外参数
        cmake_install_options        = {},
        -- 传给 `cmake --preset …` 时的选项，例：开启 compile_commands.json
        cmake_generate_options       = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        -- compile_commands.json 处理方式：软链、复制、LSP 读取或不做任何事
        cmake_compile_commands_options = {
            action = "soft_link",  -- 可选 soft_link, copy, lsp, none
        },
        -- 生成目录，字符串或函数返回字符串，相对于项目根目录
        cmake_build_dir              = "build",

        -- *** 新增：彻底关闭内置浮窗通知，避免 “Invalid 'window'” 错误 ***
        cmake_notifications = {
            runner   = { enabled = false },
            executor = { enabled = false },
        },

        -- 可选：Overseer / ToggleTerm 集成
        -- overseer = { task_params = { ... } },
        -- toggleterm = { ... },
    },
    -- 快捷键（任选其一放到你的 keymap 配置里）
    config = function(_, opts)
        require("cmake-tools").setup(opts)
        local wk = require("which-key")
        wk.register({
            c = {
                name = "CMake",
                g = { "<Cmd>CMakeGenerate<CR>",        "Generate"           },
                b = { "<Cmd>CMakeBuild<CR>",           "Build"              },
                r = { "<Cmd>CMakeRun<CR>",             "Run"                },
                t = { "<Cmd>CMakeTest<CR>",            "CTest"              },
                s = { "<Cmd>CMakeSelectBuildType<CR>", "Select Build Type"  },
                p = { "<Cmd>CMakeSelectPreset<CR>",    "Select Preset"      },
                l = { "<Cmd>CMakeClean<CR>",           "Clean"              },
            },
        }, { prefix = "<leader>" })
    end,
}

