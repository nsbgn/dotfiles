vim.pack.add{
  { src = 'https://github.com/ibhagwan/fzf-lua', version = "511651f198068ef5841ee1635ade58daa2486ef7" }
}

require("fzf-lua").setup {
  winopts = { fullscreen = true, border = 'single'  },
  fzf_opts = { ["--exact"] = true },
}


local fzf = require("fzf-lua")

vim.keymap.set('n', '<Leader><Space>', fzf.builtin)
vim.keymap.set('n', '<Leader>a', fzf.buffers)
vim.keymap.set('n', '<Leader>f', fzf.files)
vim.keymap.set('n', '<Leader>g', fzf.live_grep)
vim.keymap.set('n', '<Leader>s', fzf.lsp_document_symbols)
vim.keymap.set('n', '<Leader>c', fzf.git_commits)
