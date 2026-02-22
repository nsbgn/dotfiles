return {
-- Folds
  { 'https://github.com/kevinhwang91/nvim-ufo',
    enabled = false,
    dependencies = {'https://github.com/kevinhwang91/promise-async' },
    init = function()
      if vim.version().minor >= 12 or vim.version().major > 0 then
        vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'
      end
      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end,
      })
    end
  },
}
