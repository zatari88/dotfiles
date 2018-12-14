" Set my default colorscheme if base16 is not configured yet
colorscheme Tomorrow-Night

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

nnoremap j gj
nnoremap k gk

" Configure tabs
set tabstop=4
set softtabstop=4
"set expandtab

set autoindent

" Configure changing how linenumbers look based on mode
set number
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

set colorcolumn=80
highlight ColorColumn ctermbg=8

set lazyredraw

" configure where swap files go
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

