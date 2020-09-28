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
highlight ColorColumn ctermbg=18

set lazyredraw

" configure where swap files go
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

"Start WSL terminal clipbaord support
func! GetSelectedText()
    normal gv"xy
    let result = getreg("x")
    return result
endfunc

if !has("clipboard") && executable("clip.exe")
    noremap <C-C> :call system('clip.exe', GetSelectedText())<CR>
    noremap <C-X> :call system('clip.exe', GetSelectedText())<CR>gvx
endif
"End WSL terminal clipboard support
