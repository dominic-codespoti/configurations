local opts = {
    exclude = {
        buftypes = {
            "terminal",
            "nofile"
        },
        filetypes = {
            "help",
            "terminal",
            "lazy",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "mason",
            "alpha",
            ""
        }
    }
}

return opts;
