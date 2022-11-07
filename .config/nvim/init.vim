" Install vim-plug if not available
" <https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation>
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin(stdpath('data') . '/plugged')
    Plug 'https://github.com/neovim/nvim-lspconfig'

    " Telescope
    Plug 'https://github.com/nvim-lua/plenary.nvim'
    Plug 'https://github.com/nvim-telescope/telescope.nvim'

    " Distraction-free writing
    Plug 'https://github.com/folke/zen-mode.nvim'

    " Fuzzy finding
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/fzf.vim'

    " Return to last position when editing files
    Plug 'https://github.com/farmergreg/vim-lastplace'

    " Inertial scrolling
    Plug 'https://github.com/psliwka/vim-smoothie'

    " Sets working directory to project root
    Plug 'https://github.com/airblade/vim-rooter.git'

    " Show git/svn changes
    Plug 'https://github.com/mhinz/vim-signify.git'

    " Visually indicate marks
    Plug 'https://github.com/kshenoy/vim-signature'

    " Auto comment lines
    Plug 'https://github.com/tpope/vim-commentary'

    " More sensible word motions
    Plug 'https://github.com/chaoren/vim-wordmotion'

    " Moving around. Comfortable middle ground between hop and sneak
    Plug 'https://github.com/ggandor/leap.nvim'

    Plug 'https://github.com/dstein64/nvim-scrollview'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'https://github.com/nvim-neo-tree/neo-tree.nvim'

    " cf <https://nic-west.com/posts/workman-layout/>
    Plug 'https://github.com/nicwest/vim-workman'

    " Syntax highlighting
    Plug 'https://github.com/niklasl/vim-rdf'
    Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
    Plug 'https://github.com/vito-c/jq.vim'
    Plug 'https://github.com/kovetskiy/sxhkd-vim'
    Plug 'https://github.com/ledger/vim-ledger', { 'tag': 'v1.2.0' }
    Plug 'https://github.com/dylon/vim-antlr'
call plug#end()

set background=light
set fillchars+=eob:\  " turn off tildes at the end of buffers

highlight Pmenu ctermfg=white ctermbg=black

" Vertical splits are more subtle
highlight VertSplit cterm=NONE ctermfg=gray
set fillchars+=vert:▏  "│┆▕▁│▁▏

" Blinking cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

" Show file in window title
set title
set titlestring=%f\ %m

" Check if a plugin is loaded
function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ stridx(&rtp, substitute(g:plugs[a:name].dir,"/$","","")) >= 0)
endfunction

" Stop annoying window from popping up
map q: :q

" cursor makes it obvious what mode I am in anyway
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
"set number! relativenumber!


" Get rid of fileinfo in command line
"set shortmess=F

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

" Open in browser with gx
nmap gx <Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>

" Always move by screen lines, not real lines
noremap <silent> k gk
noremap <silent> j gj

vmap <silent> ' S"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File-specific configuration

if has("autocmd")
    " formatoptions:
    " - a sets our text to automatically wrap when it reaches textwidth
    " - w defines paragraphs as being separated by a blank line
    " - t sets text to be automatically formatted to textwidth
    " - q allows the gq command to automatically reformat text


    autocmd VimEnter *.md nested :ZenMode

    augroup pandoc_syntax
        au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
        au! BufNewFile,BufFilePre,BufRead *.mail set filetype=markdown.pandoc
        autocmd FileType markdown.pandoc setlocal conceallevel=0 formatoptions+=aw2tq wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4
    augroup END

    augroup latex
    "   https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
    "   https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
        au! BufNewFile,BufRead,BufRead *.tex set filetype=tex
        autocmd FileType tex setlocal conceallevel=0
        autocmd FileType tex setlocal formatoptions+=aw2tq
        autocmd FileType tex setlocal wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4
    augroup END

    augroup haskell
        au! BufNewFile,BufFilePre,BufRead *.hs set filetype=haskell
        autocmd FileType haskell setlocal tabstop=2
        autocmd FileType haskell setlocal shiftwidth=2
        autocmd FileType haskell setlocal softtabstop=2
    augroup END

    augroup lua
        au! BufNewFile,BufFilePre,BufRead *.lua set filetype=lua
        autocmd FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2
    augroup END


endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration

if PlugLoaded('vim-pandoc-syntax')
    let g:pandoc#syntax#conceal#use=0
endif

" So that the first match in leap.nvim is shown
" See https://github.com/ggandor/leap.nvim/issues/27
highlight Cursor ctermbg=White ctermfg=Black

highlight htmlH1 cterm=bold ctermfg=DarkMagenta
highlight pandocAtxHeader cterm=bold ctermfg=DarkMagenta
highlight pandocSetexHeader cterm=bold ctermfg=DarkMagenta
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE
highlight SignifySignAdd ctermfg=Green cterm=NONE
highlight SignifySignDelete ctermfg=DarkRed cterm=NONE
highlight SignifySignChange ctermfg=Magenta cterm=NONE

if PlugLoaded('vim-antlr')
    au BufRead,BufNewFile *.g set filetype=antlr3
    au BufRead,BufNewFile *.g4 set filetype=antlr4
endif

" Language servers
lua require('lsp')

" Use qwerty-to-workman `langmap` in normal mode
if PlugLoaded('vim-workman')
    let g:workman_normal_workman = 0
    let g:workman_insert_workman = 0
    let g:workman_normal_qwerty = 0
    let g:workman_insert_qwerty = 0
endif

if PlugLoaded('vim-rooter')
    let g:rooter_silent_chdir = 1
    let g:rooter_change_directory_for_non_project_files = 'current'
    let g:rooter_resolve_links = 1
    let g:rooter_patterns = ['.git', 'Makefile']
endif

if PlugLoaded('vim-signify')
    set signcolumn=auto
    let g:signify_sign_add               = '✚'
    let g:signify_sign_delete            = '✖'
    let g:signify_sign_delete_first_line = '●'
    let g:signify_sign_change            = '✱'
endif

if PlugLoaded('vim-expand-region')
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)
endif

if PlugLoaded('vim-smoothie')
    let g:smoothie_no_default_mappings = 1
    nnoremap <unique> <PageUp> <cmd>call smoothie#do("\<C-U>") <CR>
    nnoremap <unique> <PageDown> <cmd>call smoothie#do("\<C-D>") <CR>
    vnoremap <unique> <PageUp> <cmd>call smoothie#do("\<C-U>") <CR>
    vnoremap <unique> <PageDown> <cmd>call smoothie#do("\<C-D>") <CR>
endif

if PlugLoaded('fzf.vim')
    nmap gj :Files<CR>
    nmap gb :Buffers<CR>
    nmap gl :Lines<CR>
    nmap gm :Marks<CR>
endif

if PlugLoaded('telescope.nvim')
    nnoremap gf <cmd>Telescope git_files<cr>
    nnoremap gF <cmd>Telescope find_files<cr>
    nnoremap gj <cmd>Telescope live_grep<cr>
    nnoremap gb <cmd>Telescope buffers<cr>
    nnoremap gd <cmd>Telescope lsp_definitions<cr>
endif

" if PlugLoaded('vim-buftabline')
"     " Show buffers in tabline, but only if there is more than one
"     let g:buftabline_show = 1
" endif

nnoremap ; :

" Navigating buffers
" close buffer, see:
" - https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
" - https://github.com/qpkorr/vim-bufkill
nmap td :bp<bar>sp<bar>bn<bar>bd<CR>
" force close buffer:
nmap tD :bd!<CR>
" open new file:
" nmap tt :Lf<CR>

lua require('leap').add_default_mappings()
lua require('leap').opts.highlight_unlabeled_phase_one_targets = true

nmap t :NeoTreeFocus<CR>

set showtabline=0

" Turn hard wrapped text into soft wrapped.
" This command will join all lines within a range that are not separated
" by empty lines. Automatic word wrap must be off (set fo-=a).
" Useful if you need to copy and paste into a word processor.
" source: https://gist.github.com/alols/1420072
command! -range=% SoftWrap
            \ <line2>put _ |
            \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x

