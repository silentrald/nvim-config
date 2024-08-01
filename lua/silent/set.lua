vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 2
vim.opt.foldnestmax = 10

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.cindent = true

vim.opt.listchars = "tab:>-,trail:.,lead:."
vim.opt.list = true

vim.opt.encoding = "UTF-8"
vim.opt.path = "**"

vim.opt.termguicolors = true

vim.opt.scrolloff = 4

vim.opt.updatetime = 50

-- System clipboard config; then either install xclip or wl-clipboard
vim.opt.clipboard:append("unnamedplus")
