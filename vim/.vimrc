""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up the functionality
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disallow opening directories. If any arg is a directory, quit
for f in argv()
    if isdirectory(f)
        echomsg "vimrc: Cowardly refusing to edit directory " . f
        quit
    endif
endfor

" Set j and k to move up and down by visual lines rather than line numbers
nnoremap j gj
nnoremap k gk

" Configure tabs
set tabstop=4
set softtabstop=4
set expandtab
set autoindent

" Makes refresh a little faster. Don't redraw everything
set lazyredraw
set ttyfast

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

" Make searching more intuitive
set hlsearch
set ignorecase
set smartcase   " Captital letters in search terms forces case sensitive
" Manually set case:
"    ignore case: /{search term}\c
"    follow case: /{search term}\C

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up the aesthetics
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set my default colorscheme if base16 is not configured yet
colorscheme Tomorrow-Night

" Open base16 config if it is set up
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" Configure changing how linenumbers look based on mode
set number
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

set colorcolumn=80
highlight ColorColumn ctermbg=18

" Show a specific set of whitespace characters
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
"set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:$
"set listchars=tab:|\ ,trail:_,extends:>,precedes:<,nbsp:~

set noerrorbells
set showmode
