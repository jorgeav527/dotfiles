require('neo-tree').setup({
  hijack_netrw_behavior = 'open_default',
  close_if_last_window = true,
  window = {
    width = 30,
    mappings = {
      ['<space>'] = 'none',
      ['l'] = 'open',
      ['c'] = 'close_node',
      ['v'] = 'open_vsplit',
      ['h'] = 'open_split',
    },
  },
  filesystem = {
    filtered_items = {
      show_hidden = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
  }
})
