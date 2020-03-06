"--------------------------------------------------------------
" 系統設定
"--------------------------------------------------------------

" 設定 <Leader> 鍵
let g:mapleader = ","
let mapleader = ","
set timeout timeoutlen=1500

set clipboard=unnamedplus

" 可用滑鼠操作
set mouse=a

" 顯示「行標」
set cursorline

" 離開插入模式，回返一般模式
imap jj <Esc>

" 設定〔行號〕顯示模式
set number                  " 顯示行號
set relativenumber          " 在遊標所在處顯示相對行號

" 變更行號顯示模式
nmap <leader>nu :set number<CR>             " :set nu
nmap <leader>n! :set nonumber<CR>           " :set nu!
nmap <leader>NU :set relativenumber<CR>     " :set rnu
nmap <leader>N! :set norelativenumber<CR>   " :set nornu


"--------------------------------------------------------------
" 檔案作業

" 停用 backup 與 swap 功能
set nobackup
set nowritebackup
set noswapfile

" Automatically re-read file if a change was detected outside of vim
set autoread


" 編輯設定檔
nmap <Leader>i :tabnew ~/.config/nvim/local_init.vim<CR>

" 依據設定檔重啟設定
nmap <Leader>I :source ~/.config/nvim/init.vim<CR>


" 儲存檔案
nmap <Leader>w :w<CR>
imap <Leader>w :w<CR>
vmap <Leader>w :w<CR>
nnoremap fs :w<CR>


" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

"--------------------------------------------------------------
" Tabs and spaces handling
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab               " always uses spaces instead of tab characters


" 文字搜尋：Serach configuration
set ignorecase              " 搜尋時怱略英文字母的大小寫
set smartcase               " turn on smartcase
set incsearch
set hlsearch                " highlight search results

"--------------------------------------------------------------
" 系統設定
"--------------------------------------------------------------

" Enable deoplete plugin
let g:python3_host_prog = "~/.pyenv/shims/python"

"
" 程式語言　auto-completion
"
let g:deoplete#enable_at_startup = 1

" automatically close the method preview window
autocmd InsertLeave, CompleteDone * if pumvisible() == 0 | pclose | endif

" Navigate through the auto-completion list with Tab key
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"
" 狀態指示列
"
let g:airline_theme='luna'


"
" 自動調整排版格式
"

" Vim Command
" :Neoformat! [python [yapf]]

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" Run a formatter on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

"
" 自動顯示定義處(Code Jump)
"

" Move the cursor to the class or method you want to check, then press the various supported shortcut provided by jedi-vim:
"
" - <leader>d: go to definition
" - K:         check documentation of class or method
" - <leader>n: show the usage of a name in current file
" - <leader>r: rename a name

" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = 'right'

"
" Code Checker by neomake
"
" Vim Command:
"  - Neomake: Manually start syntax checking
"  - lwindow / lopen: Navigate them using the buil-in methods
"  - lprev / lnext : Go back and forth
"
"  pylint --generate-rcfile > ~/.pylintrc
"  Usage Ref: https://stackoverflow.com/questions/4341746/how-do-i-disable-a-pylint-warning/23542817#23542817

let g:neomake_python_enabled_makers = ['pylint']

" Open the list automatically
let g:neomake_open_list = 2

" enable automatical code check: normal mode (after 1s; no delay when writing)
call neomake#configure#automake('nrwi', 500)

"
" Multiple cursor editting by vim-multiple-cursors
"
" (1) move the cursor to a variable you want to rename
" (2) press <C-n> to enter multiple cursor ediiting mode and let variable to be highlighted
" (3) if a occurance want to skip, press <C-x>
" (4) press <c> (meands to change) and enter insert mode. Input a new name.
" (5) press <ESC> to exit multiple cursor editting mode
