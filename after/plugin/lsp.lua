local lsp_zero = require('lsp-zero')
local ts_utils = require('nvim-treesitter.ts_utils')

lsp_zero.on_attach(function(_client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set('n', ']g', function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set('n', '[g', function()
    vim.diagnostic.goto_prev()
  end, opts)

  -- Unknown for me
  vim.keymap.set('n', '<leader>vws', function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  vim.keymap.set('n', '<leader>vd', function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set('n', '<leader>vca', function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set('n', '<leader>vrr', function()
    vim.lsp.buf.references()
  end, opts)
  vim.keymap.set('n', '<leader>vrn', function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set('i', '<C-h>', function()
    vim.lsp.buf.signature_help()
  end, opts)

  -- Forward Parameter jumping
  -- Only works for cpp
  vim.keymap.set('i', '<Tab>', function()
    local node = ts_utils.get_node_at_cursor()
    if node:type() == 'parameter_list' or node:type() == 'argument_list' then
      local _, cursor_position = unpack(vim.api.nvim_win_get_cursor(0))
      local child = node:named_child()
      while child ~= nil do
        local _, start, _ = child:start()

        if cursor_position < start then
          local end_ = 0
          local sibling = child:next_sibling()
          -- For some reason, parameter names can be error
          if sibling:type() == 'ERROR' then
            _, end_, _ = sibling:end_()
          else
            _, end_, _ = child:end_()
          end
          return '<esc>' .. start + 1 .. '|v' .. end_ .. '|<C-g>'
        end
        child = child:next_named_sibling()
      end
    end
    return '<Tab>'
  end, { silent = true, expr = true, noremap = true })

end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',
    'rust_analyzer',
    'clangd',
    'html',
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    pylsp = function()
      require('lspconfig').pylsp.setup({
        settings = {
          pylsp = {
            configurationSources = { 'flake8' },
            plugins = {
              flake8 = {
                enabled = true,
                ignore = {
                  'E203',
                  'E402',
                },
                maxLineLength = 80,
              },
              mccabe = { enabled = false },
              pycodestyle = { enabled = false },
              pyflakes = { enabled = false },
            },
          },
        },
      })
    end,
    rust_analyzer = function()
      return true
    end,
    ts_ls = function()
      local mason_registry = require('mason-registry')
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
      print('vue language server path ' .. vue_language_server_path)
      require('lspconfig').ts_ls.setup({
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
              languages = { 'vue' },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      })
    end,
  },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  preselect = true,
  confirmation = { completeopt = 'menu,menuone,noinsert' },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'buffer', keyword_length = 3 },
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] =  cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- Configured ctrl+return = \n (konsole override)
    ['<NL>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    ['<C-Space>'] = cmp.mapping({
      i = function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end,
      c = function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end,
    }),
  }),
})

-- Close char pairs
require('nvim-autopairs').setup()

-- Commenting
require('Comment').setup({})
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', {})
vim.api.nvim_set_keymap('v', '<C-_>', 'gc', {})

-- Todo
require('todo-comments').setup()

-- Formatters
local conform = require('conform')
local formatters = {}
formatters['clang-format'] = {
  command = 'clang-format'
}
conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    css = { 'prettier' },
    html = { 'prettier' },
    json = { 'prettier' },
    vue = { 'prettier' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    hpp = { 'clang-format' },
  },
  formatters = formatters
})

function format_on_save()
  conform.format({
    lsp_fallback = true,
    async = false,
  })
end
-- for _i, filetype in ipairs({ 'js', 'ts', 'vue', 'css', 'html', 'json' }) do
--   vim.api.nvim_create_autocmd('BufWritePre', {
--     pattern = '*.' .. filetype,
--     callback = function(args)
--       format_on_save()
--     end,
--   })
-- end
vim.keymap.set({ 'n', 'v' }, '<A-s>', format_on_save)

-- Linters
local lint = require('lint')
lint.linters_by_ft = {
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  vue = { 'eslint_d' },
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({
  'BufEnter',
  'BufWritePost',
  'InsertLeave',
}, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
