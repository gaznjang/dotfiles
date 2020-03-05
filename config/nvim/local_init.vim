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
