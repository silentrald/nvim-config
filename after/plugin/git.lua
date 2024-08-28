require('gitblame').setup {
  enabled = true,
  message_template = '> <committer>, <summary> (<committer-date>)',
  date_format = '%Y-%m-%d, %I:%M %p',
  highlight_group = 'Blamer',
}

--[[
vim.g.blamer_enabled = true
vim.g.blamer_delay = 25
vim.g.blamer_prefix = '> '
vim.g.blamer_template = '<committer>, <summary> (<committer-time>)'
vim.g.blamer_date_time = '%m/%d/%Y, %I:%M %p'
vim.g.blamer_show_in_visual_modes = false
vim.g.blamer_show_in_insert_modes = false
--]]

vim.api.nvim_set_hl(0, 'Blamer', { fg = 'red' })

-- vim.api.nvim_command('Diff DiffviewOpen')
vim.api.nvim_cmd({
  cmd = 'command',
  args = {
    'Diff',
    'DiffviewOpen'
  }
}, {})

