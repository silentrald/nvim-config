vim.g.mapleader = ' '
vim.keymap.set('n', "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', '<C-S-Down>', ':m .+1<CR>==')
vim.keymap.set('n', '<C-S-Up>', ':m .-2<CR>==')
vim.keymap.set('i', '<C-S-Down>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<C-S-Up>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('v', '<C-S-Down>', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', '<C-S-Up>', ':m \'<-2<CR>gv=gv')

vim.keymap.set('n', '<C-s>', ':w<CR>')

vim.api.nvim_set_keymap('n', '<A-Up>', ':wincmd k<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-Down>', ':wincmd j<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-Left>', ':wincmd h<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-Right>', ':wincmd l<CR>', { noremap = true, silent = true})

vim.keymap.set('n', '<C-t>', ':tabnew<CR>')
vim.keymap.set('n', '<C-x>', ':tabclose<CR>')
vim.keymap.set('n', '<C-y>', ':tabnext<CR>')

vim.api.nvim_cmd({
  cmd = 'command',
  args = {
    'Todo',
    'TodoLocList'
  }
}, {})


