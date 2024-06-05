
require('nvim-tree').setup({
  renderer = {
    full_name = true,
    group_empty = true,
    symlink_destination = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "signcolumn",
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = true,
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false
      }
    }
  }
})
-- vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=none")
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'none', fg = 'none' })
vim.api.nvim_set_hl(0, 'NvimTreeNormalNC', { bg = 'none', fg = 'none' })

require('nvim-web-devicons').setup()

-- Keymaps
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>')
