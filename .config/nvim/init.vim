" lua require('plugins')
" lua require('lsp')
lua require('plugins')
lua vim.keymap.set('n', '<space><space>', ':')

" Do not write which mode I am in; cursor should make that obvious anyway
set noshowmode

" Don't show status bar, etc
set laststatus=0
set noshowcmd

" Enable mouse support
set mouse=a

" Width is 79 characters by default
set textwidth=79

" Show column number, line number and relative position in status line
set ruler

" Show line numbers in left margin
set nonumber
nmap <Tab> :set number!<CR>

set smoothscroll " cf. https://github.com/neovim/neovim/pull/23320
set scrolloff=5
set signcolumn=yes

" Get rid of fileinfo in command line
set shortmess=F

" Indentation behaviour
set autoindent " Copy indentation from previous line
set expandtab " Convert tabs to spaces
set tabstop=4
set shiftwidth=4 " Number of characters for indentation (> and <)
set softtabstop=4 " Tab and backspace insert and delete correct number of spaces

" Do not automatically put two spaces after a sentence
set nojoinspaces

" Backspace over indentations
set backspace=indent,eol,start

" Move to previous/next line when pressing left/right at beginning/end
set whichwrap=<,>,h,l,[,]

" Show completion menu and, on tab, complete to the longest common command
set wildmenu
set wildmode=longest,list,full

" Copy to system clipboard by default
set clipboard=unnamedplus

" Show visible indication for tabs & spaces
set list
set listchars=tab:⇥\ ,trail:⸱,nbsp:⎵ " 

set fillchars+=vert:*
set fillchars+=eob:\  " turn off tildes at the end of buffers

" Disable swapfile
set noswapfile

" Show file in window title, with icon 🗒️  
set title
set titlestring=\ %(%{ReplaceHomeWithTilde(expand(\"%:p\"))}%)\ %m


" Formatting """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always move by screen lines, not real lines
noremap <silent> k gk
noremap <silent> j gj

" Formatoptions:
" - a sets our text to automatically wrap when it reaches textwidth
" - w defines paragraphs as being separated by a blank line
" - t sets text to be automatically formatted to textwidth
" - q allows the gq command to automatically reformat text
" set formatoptions+=aw2tq

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.mail set filetype=markdown.pandoc
    autocmd FileType markdown.pandoc setlocal conceallevel=0 formatoptions+=aw2tq wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4
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

" Remappings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open in browser with gx
nmap gx <Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>
" Stop annoying window from popping up
map q: :q
nnoremap ; :
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" lua << EOF
" vim.fn.sign_define("DiagnosticSignError",
"   {text = " ", texthl = "DiagnosticSignError"})
" vim.fn.sign_define("DiagnosticSignWarn",
"   {text = " ", texthl = "DiagnosticSignWarn"})
" vim.fn.sign_define("DiagnosticSignInfo",
"   {text = " ", texthl = "DiagnosticSignInfo"})
" vim.fn.sign_define("DiagnosticSignHint",
"   {text = "", texthl = "DiagnosticSignHint"})
" EOF

" Colorscheme stuff """""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set background=light
colorscheme peachpuff

hi Normal guifg=black ctermbg=NONE guibg=NONE ctermbg=NONE guibg=NONE
hi Visual guifg=#cccccc guibg=#333333

hi Comment gui=italic guifg=gray
hi Special gui=NONE guifg=gray
hi Statement gui=bold guifg=black
hi Constant gui=italic guifg=darkgreen
hi Identifier gui=NONE guifg=darkred
hi Type gui=italic guifg=black
hi PreProc gui=bold guifg=black
hi Todo gui=underline,bold
hi MatchParen gui=bold guifg=black guibg=lightgray

hi DiffAdd guifg=darkgreen guibg=NONE
hi DiffChange guifg=gray guibg=NONE
hi DiffDelete guifg=darkred guibg=NONE

hi NonText guifg=#888888

hi LeapBackdrop guifg=gray
hi LeapLabelPrimary gui=bold,italic guibg=white
hi LeapMatch guifg=black guibg=white
hi ScrollView guifg=red guibg=black

hi markdownH1 gui=underline,bold
hi markdownH2 gui=underline,bold,italic
hi markdownH3 gui=underline,italic
hi markdownItalic gui=italic
hi markdownItalicDelimiter gui=italic guifg=gray
hi markdownBold gui=bold
hi markdownBoldDelimiter gui=bold guifg=gray
hi markdownCode guibg=#eeeeee
hi markdownAutomaticLink gui=underline
hi yamlBlockMappingKey gui=bold guifg=black
hi yamlDocumentStart gui=none guifg=gray
hi pythonBuiltin gui=none guifg=black
hi pythonFunction gui=bold guifg=darkred


" cf.https://www.jamescherti.com/vim-script-replace-the-home-directory-with-a-tilde/
function! ReplaceHomeWithTilde(path) abort
  let l:path = fnamemodify(a:path, ':p')
  let l:path_sep = (!exists('+shellslash') || &shellslash) ? '/' : '\'
  let l:home = fnamemodify('~', ':p')

  if l:path[0:len(l:home)-1] ==# l:home
    return '~' . l:path_sep . l:path[len(l:home):]
  elseif l:path == l:home
    return '~' . l:path_sep
  endif

  return l:path
endfunction
