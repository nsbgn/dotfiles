vim.g.mapleader = ' '

-- Do not write which mode I am in; cursor should make that obvious anyway
vim.o.showmode = false

-- Don't show status bar, etc
vim.o.laststatus = 0
vim.o.showcmd = false

vim.o.termguicolors = true

vim.o.breakindent = true

-- for searching and flash.nvim matching
vim.o.ignorecase = true

-- Enable mouse support
vim.o.mouse = "a"

-- Width is 79 characters by default
vim.o.textwidth = 79

-- Show column number, line number and relative position in status line
vim.o.ruler = true

-- Show line numbers in left margin
vim.o.number = false

vim.o.smoothscroll = true -- cf. https://github.com/neovim/neovim/pull/23320
vim.o.scrolloff = 5
vim.o.signcolumn = "yes"

-- Get rid of fileinfo in command line
vim.o.shortmess = "F"

-- Indentation behaviour
vim.o.autoindent = true -- Copy indentation from previous line
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4 -- Number of characters for indentation (> and <)
vim.o.softtabstop = 4 -- Tab and backspace insert and delete correct number of spaces

-- Do not automatically put two spaces after a sentence
vim.o.joinspaces = false

-- Backspace over indentations
vim.opt.backspace = "indent,eol,start"

-- Move to previous/next line when pressing left/right at beginning/end
vim.opt.whichwrap="b,<,>,h,l,[,]"

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

-- Show file in window title, with icon
vim.o.title = true
-- vim.o.titlestring = "%(%{ReplaceHomeWithTilde(expand(\"%:p\"))}%)%m"
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

-- Open terminal
vim.keymap.set('n', '<C-t>', ':terminal<CR>i', { nowait = true })
-- vim.keymap.set('t', '<C-t>', '<C-d>')
-- vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:bd<CR>')

-- Formatting --

vim.cmd([[
" Formatoptions:
" - a sets our text to automatically wrap when it reaches textwidth
" - w defines paragraphs as being separated by a blank line
" - t sets text to be automatically formatted to textwidth
" - q allows the gq command to automatically reformat text
" set formatoptions+=aw2tq

augroup markdown
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    au! BufNewFile,BufFilePre,BufRead *.mail set filetype=markdown
    autocmd FileType markdown setlocal conceallevel=0 formatoptions+=aw2tq wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4
augroup END

augroup latex
"   https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
"   https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
"   https://stackoverflow.com/questions/7053550/disable-all-auto-indentation-in-vim
    au! BufNewFile,BufRead,BufRead *.tex set filetype=tex
    autocmd FileType tex setlocal conceallevel=0
    autocmd FileType tex setlocal formatoptions=w2qj
    autocmd FileType tex setlocal wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4 indentexpr=no
augroup END


" cf. https://www.jamescherti.com/vim-script-replace-the-home-directory-with-a-tilde/
function! ReplaceHomeWithTilde(path) abort
  let l:path = fnamemodify(a:path, ':p')
  let l:path_sep = (!exists('+shellslash') || &shellslash) ? '/' : '\'
  let l:home = fnamemodify('~', ':p')
  let l:projects = l:home . 'projects' . l:path_sep

  if l:path[0:len(l:projects)-1] ==# l:projects
    return l:path[len(l:projects):]
  elseif l:path[0:len(l:home)-1] ==# l:home
    return '~' . l:path_sep . l:path[len(l:home):]
  elseif l:path == l:home
    return '~' . l:path_sep
  endif

  return l:path
endfunction
]])

require('lsp')
require('colorscheme-gruvbox')
require('basic')
require('flash-nvim')
require('plug-cutlass')
require('plug-oil')
require('vim-rooter')
require('git')
require('mini-pick')
