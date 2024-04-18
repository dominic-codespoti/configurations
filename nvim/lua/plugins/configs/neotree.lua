local options = {
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
    },
    close_if_last_window = true,
    filesystem = {
        follow_current_file = {
          enabled = true
        },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
    },
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function(_) vim.opt_local.signcolumn = "auto" end,
        },
    }
}

return options
