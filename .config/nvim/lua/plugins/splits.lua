-- Not ideal

return {
  'https://github.com/nvim-focus/focus.nvim',
  version = '*',
  init = function()
    require("focus").setup({
      autoresize = {
        enable = false,
      },
      split = {
        bufnew = true,
      },
      ui = {
        cursorline = false,
        signcolumn = false,
      }
    })

    vim.keymap.set('n', '<C-n>', ':FocusSplitCycle<CR>', {desc = 'split'})
  end
}
