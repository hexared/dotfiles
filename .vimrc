" Base settings
let &t_ut=''
set nocompatible
filetype off
syntax on

" Plugin management
call plug#begin(has('nvim') ? '~/.local/share/nvim/site/plugged' : '~/.vim/plugged')
" Utilities
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'        " tabs and statusline
Plug 'ervandew/supertab'              " Tab for autocomplete
Plug 'yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'mrk21/yaml-vim'

" Languages
Plug 'dense-analysis/ale'
Plug 'natebosch/vim-lsc'
Plug 'hashivim/vim-terraform'
Plug 'lepture/vim-jinja'
Plug 'tbastos/vim-lua'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ekalinin/Dockerfile.vim'

" Snippets (choose one approach)
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" Debugging (Neovim only)
if has('nvim')
  Plug 'puremourning/vimspector'
endif

" Color schemes
Plug 'romgrk/doom-one.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'tomasiser/vim-code-dark'
Plug 'BrainDeath0/Hypsteria'
Plug 'ghifarit53/tokyonight-vim'
Plug 'adrian5/oceanic-next-vim'
Plug 'sainnhe/forest-night'
Plug 'haishanh/night-owl.vim'
Plug 'joshdick/onedark.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'chriskempson/base16-vim'

call plug#end()
filetype plugin indent on

" Leader config
let g:mapleader = "\<Tab>"

" Formatting
augroup autoformat_settings
  autocmd!
  set foldmethod=syntax
  autocmd FileType go                       noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!gofmt %<CR>:loadview<CR>
  autocmd FileType html,css,javascript      noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!js-beautify %<CR>:loadview<CR>
  autocmd FileType rust                     noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!rustfmt %<CR>:loadview<CR>
  autocmd FileType python                   noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!autopep8 %<CR>:loadview<CR>
  autocmd FileType c,cpp,java               noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!clang-format -style=file %<CR>:loadview<CR>
  autocmd FileType json                     noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!jsonlint %<CR>:loadview<CR>
  autocmd FileType sh                       noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!shfmt %<CR>:loadview<CR>
  autocmd FileType vim                      setlocal foldmethod=marker
augroup end

" FZF/CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|bin|out)$',
  \ 'file': '\v\.(exe|so|dll|class|bin|out)$',
  \ }
set grepprg=rg
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_clear_cache_on_exit = 0

" Airline -> bufferline
let g:airline#extensions#tabline#enabled = 1

" Snippets config
let g:snipMate = { 'snippet_version' : 1 }

" Programming keys
let g:subtype = ""
map <silent> <leader>[ :<C-u>execute '!zeal ' . &filetype . "," . subtype . ":" . expand("<cword>") . " &>> /dev/null &"<CR><CR>
map <silent> <C-]> :CtrlPTag<cr><C-\>w
noremap <C-T> :tabnew<CR>
noremap <C-F> :Files<CR>
noremap <C-B> :Buffer<CR>
autocmd FileType java noremap <buffer> <F8> :<C-u>:new<CR>:0read !analyze-pmd.sh<CR>gg

" Python paths
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" Visual Mode
vnoremap <C-c> :'<,'>w !xclip -sel clip<CR><CR>
#if has('nvim')
#  nnoremap V <C-v>
#endif

" Tabs Navigation
map <Tab> :bn<CR>
map <S-Tab> :bp<CR>
nnoremap <C-c> :bp<bar>sp<bar>bn<bar>bd!<CR>

" Window resizing
noremap <S-M-Up> :2winc+<cr>
noremap <S-M-Down> :2winc-<cr>
noremap <S-M-Left> :2winc><cr>
noremap <S-M-Right> :2winc<<cr>

" Theme switching
map <C-S-n> :colorscheme doom-one<cr>
map <leader>n :colorscheme doom-one<cr>
map <C-S-d> :colorscheme github<cr>
map <leader>d :colorscheme github<cr>

" Window resize
autocmd VimResized * :wincmd =

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set noswapfile

" Terminal colors
set encoding=utf8
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme doom-one

" Performance settings
set lazyredraw ttyfast synmaxcol=200 ttimeoutlen=20
set mouse=a
set hidden
set wildmenu
set backspace=indent,eol,start
set laststatus=2
set splitright splitbelow
set autoindent smartindent
set expandtab shiftwidth=4 tabstop=4 softtabstop=4
set hlsearch incsearch ignorecase smartcase
set nowrap
set number
set relativenumber
let &colorcolumn="80"
filetype plugin on

" LSP bindings
augroup lspbindings
    autocmd! lspbindings
    autocmd Filetype c,cpp,python,go nnoremap <buffer> K  :<C-u>LSClientShowHover<CR>
    autocmd Filetype c,cpp,python,go nnoremap <buffer> <leader>d :<C-u>vert LSClientGoToDefinitionSplit<CR>
    autocmd Filetype c,cpp,python,go nnoremap <buffer> <leader>m :<C-u>LSClientFindReferences<CR>
    autocmd Filetype c,cpp,python,go nnoremap <buffer> <leader>r :<C-u>LSClientRename<CR>
augroup end

" Misc file settings
augroup misc
    autocmd! misc
    au! BufNewFIle,BufReadPost *.{yaml,yml} set filetype=yaml
    autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd BufRead,BufNewFIle *file setlocal ts=2 sts=2 sw=2 expandtab
    autocmd BufWritePost * silent! :call GenTags()
augroup end

" ALE
let g:ale_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],}
let g:ale_yaml_yamllint_options = '-d "{extends: default, rules: {line-length: disable, truthy: disable}}"'
let g:lsc_auto_completeopt='menu,menuone,popup,noselect,noinsert'
let g:lsc_server_commands = {
    \ "python": "pyls",
    \ "go": {
    \    "command": "gopls serve",
    \    "log_level": -1,
    \ },
    \ 'cpp' : {
    \   'name': 'cpp',
    \   'command': 'clangd --log=error',
    \ },
    \ 'c' : {
    \   'name': 'c',
    \   'command': 'clangd --log=error',
    \ },
    \}

let g:ale_linters = {
    \   'c':      ['cc', 'ccls', 'clangd'],
    \   'cpp':    ['cc', 'ccls', 'clangd'],
    \   'go':     ['gobuild', 'gofmt', 'golangci-lint', 'golint', 'gopls', 'govet'],
    \   'python': ['flake8', 'mypy', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylint', 'pylsp'],
    \   'rust':   ['analyzer', 'cargo', 'clippy', 'rls', 'rustc'],
    \}

" LSP autostop
let g:stoplsp = 1
augroup lsp_idle_saving
    autocmd!
    autocmd InsertEnter  * ALEEnable
    autocmd BufLeave     * let g:stoplsp = 1
    autocmd CursorHold   * let g:stoplsp = 1
    autocmd CursorMoved  * let g:stoplsp = 0
    autocmd CursorMovedI * let g:stoplsp = 0
    autocmd InsertEnter  * let g:stoplsp = 0
augroup end
function! s:disable_lsp(timer_id)
    if g:stoplsp == 1
        ALEStopAllLSPs
    endif
endfun
silent call timer_start(1000 * 300, function('s:disable_lsp'), {'repeat': -1})

" Command Aliases
command W w
command Q q
