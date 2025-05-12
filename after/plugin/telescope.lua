local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-q>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.git_files, {})
vim.keymap.set('n', '<C-h>', function()
  builtin.grep_string({
    use_regex = true,
    ignorecase = true,
    search = vim.fn.input("Grep > ")
  });
end)

