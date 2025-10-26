-- `npm install -g typescript-language-server typescript`
-- Also see <https://nathan-long.com/blog/modern-javascript-tooling-in-neovim/>

vim.lsp.config('ts_ls', {
  on_attach = on_attach
})
vim.lsp.enable('ts_ls')
