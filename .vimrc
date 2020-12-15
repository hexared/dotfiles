let &t_ut=''
set nocompatible              " required
filetype off                  " required

call plug#begin('~/.vim/plugged')
" utilities
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'        " tabs and statusline
Plug 'ervandew/supertab'              " Tab fr autocomplete
Plug 'yggdroot/indentLine'
" languages
Plug 'dense-analysis/ale'
Plug 'natebosch/vim-lsc'
" snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" color schemes
Plug 'endel/vim-github-colorscheme'
Plug 'tomasiser/vim-code-dark'
Plug 'BrainDeath0/Hypsteria'
Plug 'ghifarit53/tokyonight-vim'
Plug 'adrian5/oceanic-next-vim'
Plug 'sainnhe/forest-night'
Plug 'haishanh/night-owl.vim'

call plug#end()             " required
filetype plugin indent on     " required

" Formatting
    " Ctrl+L Format Code
" This performs a write, and then pipes the file to the formatter
" :w save file, :mkview remember line, :%!formatter % to format and output,
" :loadview to return to previous line
augroup autoformat_settings
  autocmd FileType go noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!gofmt %<CR>:loadview<CR>
  autocmd FileType html,css,json noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!js-beautify %<CR>:loadview<CR>
  autocmd FileType rust noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!rustfmt %<CR>:loadview<CR>
  autocmd FileType python noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!autopep8 %<CR>:loadview<CR>
  autocmd FileType c,cpp,javascript,java noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!clang-format -style=Chromium %<CR>:loadview<CR>
  autocmd FileType sh noremap <buffer> <C-L> <Esc>:w<CR>:mkview<CR>:%!shfmt %<CR>:loadview<CR>
augroup END

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

" I Like snippets!
let g:UltiSnipsListSnippets="<c-h>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
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
noremap <C-T> :CtrlPTag<CR>
" Super-F fuzzy find files
noremap <C-F> :Files<CR>
" F-8 willl perform advanced code analyzing for JAVA
" depends on PMD and this file https://gist.github.com/89luca89/37930d89082d48441cd6fa42d1bd9bea
autocmd FileType java noremap <buffer> <F8> :<C-u>:new<CR>:0read !analyze-pmd.sh<CR>gg
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog  = '/usr/bin/python2'

""" Visual Mode
    """ Ctrl-C copy visual selection to clipboard
vnoremap <C-c> :'<,'>w !xclip -sel clip<CR><CR>

""" Tabs Navigation
    " navigate tabs Tab (fw) S-Tab (prev)
map <Tab> :bn<CR>
map <S-Tab> :bp<CR>
    " Ctrl+C close buffer ( pipe commands to fix behaviour with splits and netrw/nerdtree)
nnoremap <C-c> :bp<bar>sp<bar>bn<bar>bd!<CR>

" Shortcuts to Shift-Alt-Arrows - Alt is mapped as M in vim
noremap <S-M-Up> :2winc+<cr>
noremap <S-M-Down> :2winc-<cr>
noremap <S-M-Left> :2winc><cr>
noremap <S-M-Right> :2winc<<cr>

"shortcut night/day"
map <S-n> :colorscheme tokyonight<cr>
map <S-d> :colorscheme github<cr>

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
colorscheme tokyonight "hypsteria
set termguicolors
" set t_Co=256

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
let &colorcolumn="80"
syntax on
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
    " Refresh tags on save
    autocmd BufWritePost * silent! :call GenTags()
augroup end

" ALE
let g:ale_enabled           = 1
let g:ale_fix_on_save       = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],}
let g:ale_yaml_yamllint_options     = '-d "{extends: default, rules: {line-length: disable, truthy: disable}}"'
let g:lsc_auto_completeopt='menu,menuone,popup,noselect,noinsert'
let g:lsc_server_commands  = {
            \ "python": "pyls",
            \ "go": {
            \    "command": "gopls serve",
            \    "log_level": -1,
            \ },
            \ 'cpp' : {
            \   'name': 'cpp',
            \   'command': 'clangd',
            \ },
            \ 'c' : {
            \   'name': 'c',
            \   'command': 'clangd',
            \ },
            \}
