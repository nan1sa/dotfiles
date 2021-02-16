" vim-plug

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/vim-plug')

Plug '907th/vim-auto-save'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/csv.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'freitass/todo.txt-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-plug'
Plug 'machakann/vim-sandwich'
Plug 'mechatroner/rainbow_csv'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tyru/eskk.vim'
Plug 'tyru/skkdict.vim'
Plug 'twitvim/twitvim'

call plug#end()

" eskk.vim

" if empty(glob('~/.config/nvim/eskk.vim/SKK-JISYO.L'))
"     silent !curl -fLo ~/.config/nvim/eskk.vim/SKK-JISYO.L --create-dirs
"         \ http://openlab.jp/skk/skk/dic/SKK-JISYO.L
" endif

let g:eskk#directory = '~/.config/nvim/eskk.vim'

let g:eskk#large_dictionary = {
    \ 'path': '~/.config/nvim/eskk.vim/SKK-JISYO.L',
    \ 'sorted': 1,
    \ 'encoding': 'euc-jp',
    \ }

let g:eskk#dictionary = {
    \ 'path': '~/.config/nvim/eskk.vim/user.dict',
    \ 'sorted': 0,
    \ 'encoding': 'utf-8',
    \}

autocmd User eskk-initialize-pre call s:eskk_initial_pre()

function! s:eskk_initial_pre()
runtime! eskk-table/*.vim
endfunction

" editor

set nowrap

set fileencodings=utf-8,cp932,sjis,euc-jp,latin1

" insert space

set expandtab
set tabstop=4
set shiftwidth=4

" display

set number
set relativenumber

set cursorline
set cursorcolumn

set laststatus=2
set showtabline=2

" keymap

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

nnoremap <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <silent> <Esc><Esc> <cmd>noh<CR>

" clipboard

set clipboard+=unnamedplus

" nvim-lsp

lua require'lspconfig'.hls.setup{}
lua require'lspconfig'.rust_analyzer.setup {}

" nvim-treesitter

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
}
EOF

" vim-auto-save

let g:auto_save = 1
let g:auto_save_silent = 1

if expand("%:p") =~ 'COMMIT_EDITMSG'
    let g:auto_save = 0
else
    let g:auto_save = 1
endif

" background

syntax enable
colorscheme gruvbox
let g:gruvbox_contrast_dark = "soft"
set background=dark

autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none
autocmd VimEnter,ColorScheme * highlight LineNr ctermbg=none
autocmd VimEnter,ColorScheme * highlight SignColumn ctermbg=none
autocmd VimEnter,ColorScheme * highlight VertSplit ctermbg=none
autocmd VimEnter,ColorScheme * highlight NonText ctermbg=none

" lightline.vim

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \     'left': [['eskk', 'mode', 'paste'], ['readonly', 'filename', 'modified']]
    \ },
    \ 'component_function': {
    \     'eskk': 'eskk#statusline'
    \ }
    \ }

" restore cursor

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" filetype

autocmd Filetype make setlocal noexpandtab
autocmd Filetype csv setlocal noexpandtab
autocmd FileType csv setlocal wrap
autocmd FileType markdown setlocal wrap
