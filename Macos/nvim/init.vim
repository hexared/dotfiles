let &t_ut=''
set nocompatible              " required
filetype off                  " required
syntax on

call plug#begin('~/.vim/plugged')
" utilities
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'        " tabs and statusline
Plug 'ervandew/supertab'              " Tab fr autocomplete
Plug 'yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'mrk21/yaml-vim'
Plug 'preservim/nerdtree'
" languages
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'natebosch/vim-lsc'
Plug 'hashivim/vim-terraform'
Plug 'ekalinin/Dockerfile.vim'
"Plug 'glench/vim-jinja2-syntax'
Plug 'lepture/vim-jinja'
Plug 'itspriddle/vim-shellcheck'
Plug 'tbastos/vim-lua'
Plug 'Glench/Vim-Jinja2-Syntax'
" snippets
"Plug 'sirver/ultisnips'
"Plug 'honza/vim-snippets'
"b color schemes
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
Plug 'romgrk/doom-one.vim'


" NVIM SPECIFIC PLUGINS
" Utilities
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'sharkdp/fd'

call plug#end()             " required
filetype plugin indent on     " required

" Leader

:let mapleader = "\<Tab>"

" Formatting
" Ctrl+L Format Code
" This performs a write, and then pipes the file to the formatter
" :w save file, :mkview remember line, :%!formatter % to format and output,
" :loadview to return to previous line
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

""" CtrlP
" set ctrlp to same working directory
let g:ctrlp_working_path_mode = 'ra'
" exclude compiled files class and svns
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|bin|out)$',
\ 'file': '\v\.(exe|so|dll|class|bin|out)$',
\ }
" Use Ripgrep = superfast
set grepprg=rg
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_clear_cache_on_exit = 0

""" Airline -> bufferline
let g:airline#extensions#tabline#enabled = 1

""" GENERIC PROGRAMMING
"
" Ctrl+] will perform GoTo. Available for c, c++, objc, objcpp, cs, go, javascript, python, rust
" will use CtrlPTags if not compatible
" On compatible langs, leader+] will open the GetDoc for the function.
" leader+[ will get the Docsets on Zeal/Dash
let g:subtype = ""
map <silent> <leader>[ :<C-u>execute '!zeal ' . &filetype . "," . subtype . ":" . expand("<cword>") . " &>> /dev/null &"<CR><CR>
map <silent> <C-]> :CtrlPTag<cr><C-\>w
" Ctrl+T fuzzy find ctags
noremap <C-T> :tabnew<CR>
" Super-F fuzzy find files
noremap <C-F> :Files<CR>
noremap <C-B> :Buffer<CR>
" F-8 willl perform advanced code analyzing for JAVA
autocmd FileType java noremap <buffer> <F8> :<C-u>:new<CR>:0read !analyze-pmd.sh<CR>gg
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog  = '/usr/bin/python2'

""" Visual Mode
    """ Ctrl-C copy visual selection to clipboard
vnoremap <C-c> :'<,'>w !xclip -sel clip<CR><CR>

""" Tabs Navigation
    " navigate tabs Tab (fw) S-Tab (prevmap <Tab> :bn<CR>
map <S-Tab> :bp<CR>
    " Ctrl+C close buffer
nnoremap <C-c> :bp<bar>sp<bar>bn<bar>bd!<CR>

" Shortcuts to Shift-Alt-Arrows - Alt is mapped as M in vim
noremap <S-M-Up> :2winc+<cr>
noremap <S-M-Down> :2winc-<cr>
noremap <S-M-Left> :2winc><cr>
noremap <S-M-Right> :2winc<<cr>

" NerdTree
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <C-f> :NERDTreeFind<cr>

"shortcut night/day"
"map <C-S-n> :colorscheme tokyonight<cr>
map <C-S-n> :colorscheme doom-one<cr>
map <C-S-d> :colorscheme github<cr>
nnoremap <Leader>n :colorscheme doom-one<cr>
nnoremap <Leader>d :colorscheme github<cr>

"Telescope
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>

" ==========================================================================="
" Resize Split When the window is resized"
autocmd VimResized * :wincmd =

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set noswapfile


" play nicely with modern graphics
set encoding=utf8
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"colorscheme tokyonight
colorscheme doom-one

" functions

set lazyredraw ttyfast synmaxcol=200 ttimeoutlen=20
set mouse=a                           " it's always useful to use the mouse then needed
set hidden                            " change buffer without saving
set wildmenu                          " Tab autocomplete in command mode
set backspace=indent,eol,start        " http://vi.stackexchange.com/a/2163
set laststatus=2                      " Show status line on startup
set splitright splitbelow             " Open new splits to the right and bottom
set autoindent smartindent                              " always set autoindenting on
set expandtab shiftwidth=4 tabstop=4 softtabstop=4      " Four spaces for tabs everywhere
set hlsearch incsearch ignorecase smartcase             " Highlight search results, ignore case if search is all lowercase
set nowrap                            " play nicely with long lines
set number                            " Enable line numbers
set relativenumber                    " Enable relative line numbers
let &colorcolumn="80"
filetype plugin on

" LSP
augroup lspbindings
    autocmd! lspbindings
    " IDE keybindings
    autocmd Filetype c,cpp,python,go nnoremap <buffer> K  :<C-u>LSClientShowHover<CR>
    autocmd Filetype c,cpp,python,go nnoremap <buffer> <leader>d :<C-u>vert LSClientGoToDefinitionSplit<CR>
    autocmd Filetype c,cpp,python,go nnoremap <buffer> <leader>m :<C-u>LSClientFindReferences<CR>
    autocmd Filetype c,cpp,python,go nnoremap <buffer> <leader>r :<C-u>LSClientRename<CR>
augroup end
augroup misc
    autocmd! misc
    au! BufNewFIle,BufReadPost *.{yaml,yml}     set filetype=yaml
    autocmd Filetype yaml                       setlocal ts=2 sts=2 sw=2 expandtab
    "Docker/Vagrant/Jenkins
    autocmd BufRead,BufNewFIle *file            setlocal ts=2 sts=2 sw=2 expandtab
    " Refresh tags on save
    autocmd BufWritePost * silent! :call GenTags()
augroup end

" Snippets
let g:snipMate = { 'snippet_version' : 1 }

" ALE
let g:ale_enabled           = 1
let g:ale_fix_on_save       = 1
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'javascript': ['eslint'],
            \}
let g:ale_yaml_yamllint_options     = '-d "{extends: default, rules: {line-length: disable, truthy: disable}}"'
let g:lsc_auto_completeopt='menu,menuone,popup,noselect,noinsert'
"let g:lsc_server_commands  = {
"            \ '"python": '"pyls",
"            \ '"go": {
"            \    '"command": '"gopls serve",
"            \    '"log_level": -1,
"            \ },
"            \ 'cpp' : {
"            \   'name': 'cpp',
"            \   'command': 'clangd --log=error',
"            \ },
"            \ 'c' : {
"            \   'name': 'c',
"            \   'command': 'clangd --log=error',
"            \ },
"            \}
let g:ale_linters = {
            \   'c':            ['cc', 'ccls', 'clangd'],
            \   'cpp':          ['cc', 'ccls', 'clangd'],
            \   'go':           ['gobuild', 'gofmt', 'golangci-lint', 'golint', 'gopls', 'govet'],
            \   'python':       ['flake8', 'mypy', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylint', 'pylsp'],
            \   'rust':         ['analyzer', 'cargo', 'clippy', 'rls', 'rustc'],
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
