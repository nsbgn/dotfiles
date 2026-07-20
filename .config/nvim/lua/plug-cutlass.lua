-- add cut command on x; deletion doesn't affect copy buffer anymore
vim.pack.add{
  { src = 'https://github.com/gbprod/cutlass.nvim', version = 'v1.0.1' }
}

require("cutlass").setup({
  cut_key = 'x',
  override_del = true
})

