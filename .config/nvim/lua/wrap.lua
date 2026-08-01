vim.pack.add{
  { src = 'https://github.com/andrewferrier/wrapping.nvim', version = 'v2.1.3' },
}

local wrapping = require('wrapping')

wrapping.setup{
  create_commands = false,
  create_keymaps = false,
}

vim.keymap.set("n", "<Leader>w", wrapping.toggle_wrap_mode)
