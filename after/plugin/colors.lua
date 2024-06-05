require("tokyonight").setup({
	transparent = true,
})

vim.cmd([[colorscheme tokyonight]])

vim.api.nvim_set_hl(0, "LineNr", { fg = "#0076CC" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#0076CC" })

--[[
hi Search guibg=purple guifg=white
hi IncSearch guifg=white guibg=black
--]]
