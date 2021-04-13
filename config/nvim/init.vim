" Plugins
call plug#begin(stdpath('data') . '/plugged')

    Plug 'https://github.com/morhetz/gruvbox'
    Plug 'https://github.com/ap/vim-css-color'

    " Distraction-free writing
    Plug 'https://github.com/junegunn/goyo.vim'

    " Syntax highlighting
    Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
    Plug 'https://github.com/vito-c/jq.vim'
    Plug 'https://github.com/kovetskiy/sxhkd-vim'
    Plug 'https://github.com/ledger/vim-ledger', { 'tag': 'v1.2.0' }

    " Fuzzy finding
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/fzf.vim'

    " Inertial scrolling
    Plug 'https://github.com/yuttie/comfortable-motion.vim'

    " Work with GPG-encrypted files
    Plug 'https://github.com/jamessan/vim-gnupg.git'

    " Sets working directory to project root
    Plug 'https://github.com/airblade/vim-rooter.git'

    " Show git/svn changes
    Plug 'https://github.com/mhinz/vim-signify.git'
    " Plug 'https://github.com/tpope/vim-fugitive.git'

    " Visually indicate marks
    Plug 'https://github.com/kshenoy/vim-signature'

    " Automatic alignment
    Plug 'https://github.com/junegunn/vim-easy-align'

    " Auto-edit parentheses
    Plug 'https://github.com/tpope/vim-surround'

    " Auto comment lines
    Plug 'https://github.com/tpope/vim-commentary'

    " Moving around
    Plug 'https://github.com/easymotion/vim-easymotion'
    "Plug 'https://github.com/justinmk/vim-sneak'

    " Tabs for every buffer
    Plug 'https://github.com/ap/vim-buftabline'

    " Browse the undo tree
    Plug 'https://github.com/sjl/gundo.vim'

    " Browse within vim using the `lf` file manager
    Plug 'https://github.com/ptzz/lf.vim'
    Plug 'https://github.com/rbgrouleff/bclose.vim'
    Plug 'https://github.com/voldikss/vim-floaterm'

    " Language server protocol
    Plug 'https://github.com/natebosch/vim-lsc', { 'tag': 'v0.4.0' }
    "Plug 'https://github.com/prabirshrestha/vim-lsp'

    " Autocompletion (also needs `pip3 install pynvim`)
    " Plug 'https://github.com/Shougo/deoplete.nvim', 
    "    \ { 'do': ':UpdateRemotePlugins' }

    " Language server protocol
    "Plug 'https://github.com/autozimu/LanguageClient-neovim.git', 
    "    \ { 'branch': 'next'
    "    \ , 'do': 'bash install.sh' }

    " Floating windows for previews in nvim >= 0.4
    "Plug 'https://github.com/ncm2/float-preview.nvim'

    " Navigate symbols in the document
    "Plug 'https://github.com/liuchengxu/vista.vim'

    " Manage Pandoc files
    "Plug 'https://github.com/vim-pandoc/vim-pandoc.git'

call plug#end()

"set background=light
"let g:gruvbox_contrast_light="soft"
"let g:gruvbox_sign_column="bg0"
"colorscheme gruvbox
"
" Turn off background to take on same bg as my terminal
highlight Normal ctermbg=NONE

" Blinking cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

" Show file in window title
set title
set titlestring=\ \ %F\ %m

" Check if a plugin is loaded
function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ stridx(&rtp, substitute(g:plugs[a:name].dir,"/$","","")) >= 0)
endfunction

" cursor makes it obvious what mode I am in anyway
set noshowmode

" Don't show status bar, etc
set laststatus=0
set noshowcmd

" Enable mouse support
set mouse=a

" Width is 79 characters by default
set textwidth=79

" Don't show column number, line number and relative position in status line
set noruler

" Don't show line numbers in left margin
set nonumber

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

" Show visible indication for tabs
set list

let g:netrw_browsex_viewer = "firefox"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File-specific configuration

if has("autocmd")
    autocmd FileType lua setlocal tabstop=2 softtabstop=2 shiftwidth=2

    "au TermEnter * setlocal nonumber
    "au TermLeave * setlocal number

    au BufRead /tmp/mutt-* set tw=72

    augroup pandoc_syntax
        au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
        autocmd FileType markdown.pandoc setlocal conceallevel=0
        autocmd FileType markdown.pandoc setlocal textwidth=78
        autocmd FileType markdown.pandoc setlocal formatoptions+=a formatoptions+=w
    augroup END

    augroup latex
    "   https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
    "   https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
        au! BufNewFile,BufRead,BufRead *.tex set filetype=tex
        autocmd FileType tex setlocal conceallevel=0
        "autocmd FileType tex setlocal textwidth=78
        "autocmd FileType tex setlocal formatoptions+=a formatoptions+=w
        autocmd FileType tex setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 tabstop=2 shiftwidth=2 softtabstop=2

        autocmd FileType tex noremap <buffer> <silent> k gk
        autocmd FileType tex noremap <buffer> <silent> j gj
        autocmd FileType tex noremap <buffer> <silent> 0 g0
        autocmd FileType tex noremap <buffer> <silent> $ g$
    augroup END

    augroup haskell
        au! BufNewFile,BufFilePre,BufRead *.hs set filetype=haskell
        autocmd FileType haskell setlocal tabstop=2
        autocmd FileType haskell setlocal shiftwidth=2
        autocmd FileType haskell setlocal softtabstop=2
    augroup END

endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration

if PlugLoaded('vim-pandoc')
    let g:pandoc#modules#enabled = ['bibliographies', 'completion', 'toc', 'hypertext']
    call deoplete#custom#var('omni', 'input_patterns', {
        \ 'pandoc': '@'
        \})
endif

if PlugLoaded('lf.vim')
    " Unmap default lf key
    let g:lf_map_keys = 0

    " Unmap e, i and w in lf within vim to make sure we only use it to open a file
    " and not to start other programs within the lf session
    let g:lf_command_override = 'lf -command "map e; map i; map w"'
endif

if PlugLoaded('float-preview.nvim')
    set completeopt-=preview " extra info will now be shown in floating window
    let g:float_preview#docked = 1
    let g:float_preview#max_height = 50
    "let g:float_preview#max_width = 80
endif

if PlugLoaded('deoplete.nvim')

    "let g:deoplete#enable_at_startup = 1
    nmap <F7> :call deoplete#toggle()<CR>

    set completeopt+=menuone " show completions even if there is only one option
    set completeopt+=noinsert " don't auto-insert until selection
    set completeopt+=noselect " don't autoselect a match
    set shortmess+=c " hide 'match x of y' message

    " Set sources for autocompletion
    " Default available sources: around, buffer, file, member, omni
    call deoplete#custom#option('sources', 
        \ { '_': ['file']
        \ ,'haskell': ['file','LanguageClient','ale','lsp','ghc']
        \ , 'python': ['file','LanguageClient','ale','lsp']
        \ , 'rust': ['file','LanguageClient','ale','lsp']
        \ , 'pandoc.markdown': ['file','omni']
        \ , 'markdown': ['file','omni'] })

    " Close preview when completion is done
    " autocmd CompleteDone * pclose
    " autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    " Somehow I want to get documentation as I select autocompletions.
    " See issue at https://github.com/autozimu/LanguageClient-neovim/issues/875
    " Also - https://github.com/wincent/wincent/issues/78
endif


if PlugLoaded('LanguageClient-neovim')
    " Required for operations modifying multiple buffers like rename.
    set hidden

    " Language server protocol servers
    let g:LanguageClient_serverCommands = {
        \ 'haskell': ['hie-wrapper'],
        \ 'python': ['pyls'], 
        \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'], 
        \ }
endif

if PlugLoaded('vim-lsc')
    set shortmess-=F " avoid suppressing errors
    let g:lsc_server_commands = {'python': 'pyls'}
    let g:lsc_enable_autocomplete = v:false
    let g:lsc_auto_map = {
        \ 'GoToDefinition': '<C-]>',
        \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
        \ 'FindReferences': 'gr',
        \ 'NextReference': '<C-n>',
        \ 'PreviousReference': '<C-p>',
        \ 'FindImplementations': 'gI',
        \ 'FindCodeActions': 'ga',
        \ 'Rename': 'gR',
        \ 'ShowHover': v:true,
        \ 'DocumentSymbol': 'go',
        \ 'WorkspaceSymbol': 'gS',
        \ 'SignatureHelp': 'gm',
        \ 'Completion': 'completefunc',
        \}
endif

if PlugLoaded('vim-lsp')
    if executable('pyls')
        " pip install python-language-server
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'allowlist': ['python'],
            \ })
    endif

    function! s:on_lsp_buffer_enabled() abort
        setlocal omnifunc=lsp#complete
        setlocal signcolumn=yes
        if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> gr <plug>(lsp-references)
        nmap <buffer> gi <plug>(lsp-implementation)
        nmap <buffer> gt <plug>(lsp-type-definition)
        nmap <buffer> <leader>rn <plug>(lsp-rename)
        nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
        nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
        nmap <buffer> K <plug>(lsp-hover)

        let g:lsp_format_sync_timeout = 1000
        autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

        " refer to doc to add more commands
    endfunction

    augroup lsp_install
        au!
        " call s:on_lsp_buffer_enabled only for languages that has the server registered.
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END
endif

if PlugLoaded('vim-rooter')
    let g:rooter_silent_chdir = 1
    " this xcwd work for non project files but not for project files...
    let g:rooter_change_directory_for_non_project_files = 'current'
    let g:rooter_resolve_links = 1
    let g:rooter_patterns = ['.git', 'Makefile']
endif

if PlugLoaded('LanguageClient-neovim')
    " Language
    nnoremap <F6> :call LanguageClient_contextMenu()<CR>
    " rename current symbol:
    nmap zr :call LanguageClient#textDocument_rename()<CR>
    " show hover information (documentation etc):
    nmap zi :call LanguageClient#textDocument_hover()<CR>
    " go to definition of current symbol:
    nmap zd :call LanguageClient#textDocument_definition()<CR>
    " list where current symbol is referenced:
    nmap zk :call LanguageClient#textDocument_references()<CR>
    " list symbols in the document:
    nmap zs :call LanguageClient#textDocument_documentSymbol()<CR>
    " suggestions for actions to take:
    nmap za :call LanguageClient#textDocument_codeAction()<CR>
endif

if PlugLoaded('vim-signify')
    set signcolumn=auto
    highlight SignColumn ctermbg=NONE cterm=NONE
    highlight SignifySignAdd ctermfg=DarkGreen cterm=NONE
    highlight SignifySignDelete ctermfg=DarkRed cterm=NONE
    highlight SignifySignChange ctermfg=Blue cterm=NONE
    let g:signify_sign_add               = ''
    let g:signify_sign_delete            = ''
    let g:signify_sign_delete_first_line = ''
    let g:signify_sign_change            = ''
endif

if PlugLoaded('vim-easy-align')
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
endif

if PlugLoaded('gundo.vim')
    " View undo tree
    nnoremap <F5> :GundoToggle<CR>
endif

if PlugLoaded('vim-sneak')
    let g:sneak#s_next = 1
    let g:sneak#label = 1
endif


if PlugLoaded('goyo.vim')
    let g:goyo_width = 80
    let g:goyo_height = "100%"
    let g:goyo_linenr = 0
endif

if PlugLoaded('fzf.vim')
    nmap gf :Files<CR>
    nmap gb :Buffers<CR>
    nmap gl :Lines<CR>
    nmap gm :Marks<CR>
endif

if PlugLoaded('vim-buftabline')
    " Show buffers in tabline, but only if there is more than one
    let g:buftabline_show = 1

    " Reduce conflict with goyo
    " See https://github.com/ap/vim-buftabline/issues/64
    if PlugLoaded('goyo.vim')
        autocmd! User GoyoEnter nested call <SID>GoyoEnter()
        autocmd! User GoyoLeave nested call <SID>GoyoLeave()
        function! s:GoyoEnter() "
            set showtabline=0
        endfunction "
        function! s:GoyoLeave() "
            set showtabline=1
            :call buftabline#update(0)
        endfunction "
    endif
endif

" Navigating buffers
" close buffer:
nmap td :bd<CR>
" force close buffer:
nmap tD :bd!<CR>
" open new file:
map tt :Lf<CR>
" next buffer:
nmap . :bnext<CR>
" previous buffer:
nmap , :bprevious<CR>

" Insert lines
nmap = o<Esc>79a=<Esc>0
nmap - o<Esc>79a-<Esc>0
nmap ~ o<Esc>79a~<Esc>0

nmap <Tab> :set number! relativenumber!<CR>
nmap <Space> <Plug>(easymotion-bd-w)
nmap s <Plug>(easymotion-overwin-f2)

let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 3.3
nnoremap <silent> <PageDown> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 1)<CR>
nnoremap <silent> <PageUp> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -1)<CR>

" Clear cmd line message
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction
augroup cmd_msg_cls
    autocmd!
    autocmd CmdlineLeave :  call timer_start(1000, funcref('s:empty_message'))
augroup END

" Center everything. Adapted from:
" https://stackoverflow.com/questions/12952479/how-to-center-horizontally-the-contents-of-the-open-file-in-vim

function! CenterStop()
    let l:name = '_padding_'
    if bufwinnr(l:name) > 0
        only
    endif
    let g:centered=0
endfunction

function! CenterStart()
    let l:name = '_padding_'
    let l:width = ((&columns - &textwidth) / 2 - 5)
    if l:width > 1 && bufwinnr(l:name) <= 0
        execute 'topleft' l:width . 'vsplit +setlocal\ nobuflisted' l:name | wincmd p
        execute 'botright' l:width . 'vsplit +setlocal\ nobuflisted' l:name | wincmd p
        set fillchars+=vert:\ 
        highlight VertSplit cterm=NONE
        highlight EndOfBuffer ctermfg=black
        " bg
    endif
    let g:centered=1
endfunction

function! CenterResize()
    if g:centered == 1
        call CenterStop()
        call CenterStart()
    endif
endfunction

function! CenterToggle()
    if g:centered == 1
        call CenterStop()
    elseif g:centered == 0
        call CenterStart()
    endif
endfunction

let g:centered=0
autocmd VimResized * :call CenterResize()
autocmd QuitPre <buffer> :call CenterStop()
command! Center call CenterToggle()
call CenterStart()

set shortmess+=F  " to get rid of the file name displayed in the command line bar
