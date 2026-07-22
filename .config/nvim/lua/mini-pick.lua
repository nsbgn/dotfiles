vim.pack.add{
  { src = 'https://github.com/nvim-mini/mini.pick', version = 'v0.18.0' },
  { src = 'https://github.com/nvim-mini/mini.extra', version = 'v0.18.0' },
}

require('mini.pick').setup()
require('mini.extra').setup()

-- vim.keymap.set('n', 'zf', ':Pick files<CR>')
vim.keymap.set('n', 'zg', ':Pick grep_live<CR>')
vim.keymap.set('n', 'zb', ':Pick buffers<CR>')
vim.keymap.set('n', 'zh', ':Pick git_hunks<CR>')
vim.keymap.set('n', 'zc', ':Pick git_commits<CR>')
vim.keymap.set('n', 'zf', ':Pick git_files<CR>')
vim.keymap.set('n', 'zz', function()
  MiniExtra.pickers.diagnostic()
end)
vim.keymap.set('n', 'zs', function()
  MiniExtra.pickers.lsp{scope='document_symbol'}
end)
vim.keymap.set('n', 'zi', function()
  MiniExtra.pickers.lsp{scope='implementation'}
end)
vim.keymap.set('n', 'zr', function()
  MiniExtra.pickers.lsp{scope='references'}
end)
vim.keymap.set('n', 'zd', function()
  MiniExtra.pickers.lsp{scope='declaration'}
end)
vim.keymap.set('n', 'ze', function()
  MiniExtra.pickers.lsp{scope='definition'}
end)
vim.keymap.set('n', 'zt', function()
  MiniExtra.pickers.lsp{scope='type_definition'}
end)
vim.keymap.set('n', 'zw', function()
  MiniExtra.pickers.lsp{scope='workspace_symbol'}
end)
