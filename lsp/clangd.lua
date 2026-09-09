return {
    cmd = {
        "clangd-22",
        "--clang-tidy",
    },

    filetypes = {
        "c",
        "cpp",
    },

    root_markers = {
        ".clangd",
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
    },

    workspace_required = false,

    init_options = {
        fallbackFlags = {
            "-std=c++23",
            "-stdlib=libc++",
        },
    },
}
