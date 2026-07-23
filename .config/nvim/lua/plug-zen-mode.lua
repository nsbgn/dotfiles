vim.pack.add{
  { src = 'https://github.com/folke/zen-mode.nvim', version = 'v1.4.1' }
}

local zen = require("zen-mode")

zen.setup{
  window = {
    width = 88,
    height = 1,
  },
  options = {
    number = false,
  },
  on_open = function(_)
    vim.cmd 'cabbrev <buffer> q let b:quitting = 1 <bar> q'
    vim.cmd 'cabbrev <buffer> wq let b:quitting = 1 <bar> wq'
  end,
  on_close = function()
    if vim.b.quitting == 1 then
      vim.b.quitting = 0
      vim.cmd 'q'
    end
  end,
}

vim.api.nvim_set_hl(0, "ZenBg", { bg = "#101010" })
vim.keymap.set('n', '<Leader>z', zen.toggle)
