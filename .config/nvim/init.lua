vim.g.mapleader = ' '

-- Do not write which mode I am in; cursor should make that obvious anyway
vim.o.showmode = false

-- Don't show status bar, etc
vim.o.laststatus = 0
vim.o.showcmd = false

-- for searching and flash.nvim matching
vim.o.ignorecase = true

-- Enable mouse support
vim.o.mouse = "a"

-- Show column number, line number and relative position in status line
vim.o.ruler = true

-- Show line numbers in left margin
vim.o.number = false

vim.o.smoothscroll = true -- cf. https://github.com/neovim/neovim/pull/23320
vim.o.scrolloff = 5
vim.o.signcolumn = "yes"

-- Get rid of fileinfo in command line
vim.o.shortmess = "F"

-- Backspace over indentations
vim.opt.backspace = "indent,eol,start"

-- Move to previous/next line when pressing left/right at beginning/end
vim.opt.whichwrap="b,<,>,h,l,[,]"

-- Do not automatically put two spaces after a sentence
vim.o.joinspaces = false

-- Show completion menu and, on tab, complete to the longest common command
vim.o.wildmenu = true
vim.opt.wildmode = "longest,list,full"

-- Copy to system clipboard by default
vim.o.clipboard = "unnamedplus"

-- Show visible indication for tabs & spaces
vim.o.list = true
vim.opt.listchars = "tab:⇥ ,trail:⸱,nbsp:⎵"

vim.o.fillchars = vim.o.fillchars .. "vert:▏,horiz:─,eob: " -- turn off tildes at the end of buffers

-- Disable swapfile
vim.o.swapfile = false

-- Show file in window title
vim.o.title = true
vim.o.titlestring = "%f%m%R"

-- Remappings --

-- Prevent typos
vim.api.nvim_set_keymap('n', 'q:', ':q', { noremap = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })

-- Save with Ctrl-S
vim.api.nvim_set_keymap('n', '<C-S>', ':update<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S>', '<C-C>:update<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S>', '<C-O>:update<CR>', { noremap = true, silent = true })

-- Open file under cursor in browser with gx
vim.api.nvim_set_keymap('n', 'gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', {})

-- Always move by screen lines, not real lines
vim.keymap.set('', 'k', 'gk')
vim.keymap.set('', 'j', 'gj')
vim.keymap.set('', '<Up>', 'gk')
vim.keymap.set('', '<Down>', 'gj')
vim.keymap.set('i', '<Up>', '<C-o>gk')
vim.keymap.set('i', '<Down>', '<C-o>gj')

-- Open terminal
vim.keymap.set('n', '<C-t>', ':terminal<CR>', { nowait = true })
-- vim.keymap.set('n', '<Leader>t', ':terminal<CR>i')
-- vim.keymap.set('t', '<C-t>', '<C-d>')
-- vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:bd<CR>')

-- Disable the 'q' key
vim.keymap.set('', 'q', '<Nop>', { nowait = true })

-- Always start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
  command = "startinsert"
})

require('lsp')
require('colorscheme-gruvbox')
require('basic')
require('flash-nvim')
require('plug-cutlass')
require('plug-oil')
require('git')
-- require('mini-pick')
require('plug-fzf')
require('plug-zen-mode')
require('formatting')
require('autoroot')
