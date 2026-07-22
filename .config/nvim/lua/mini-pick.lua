vim.pack.add{
  { src = 'https://github.com/nvim-mini/mini.pick', version = 'v0.18.0' },
  { src = 'https://github.com/nvim-mini/mini.extra', version = 'v0.18.0' },
}

require('mini.pick').setup()
require('mini.extra').setup()

-- vim.keymap.set('n', '<Leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<Leader>g', ':Pick grep_live<CR>')
vim.keymap.set('n', '<Leader>b', ':Pick buffers<CR>')
vim.keymap.set('n', '<Leader>h', ':Pick git_hunks<CR>')
vim.keymap.set('n', '<Leader>c', ':Pick git_commits<CR>')
vim.keymap.set('n', '<Leader>f', ':Pick git_files<CR>')
vim.keymap.set('n', '<Leader>z', function()
  MiniExtra.pickers.diagnostic()
end)
vim.keymap.set('n', '<Leader>s', function()
  MiniExtra.pickers.lsp{scope='document_symbol'}
end)
vim.keymap.set('n', '<Leader>i', function()
  MiniExtra.pickers.lsp{scope='implementation'}
end)
vim.keymap.set('n', '<Leader>r', function()
  MiniExtra.pickers.lsp{scope='references'}
end)
vim.keymap.set('n', '<Leader>d', function()
  MiniExtra.pickers.lsp{scope='declaration'}
end)
vim.keymap.set('n', '<Leader>e', function()
  MiniExtra.pickers.lsp{scope='definition'}
end)
-- vim.keymap.set('n', '<Leader>td', function()
--   MiniExtra.pickers.lsp{scope='type_definition'}
-- end)
vim.keymap.set('n', '<Leader>w', function()
  MiniExtra.pickers.lsp{scope='workspace_symbol'}
end)
