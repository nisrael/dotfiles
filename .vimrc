" Basic Settings
set number                      " Show line numbers
set mouse=a                     " Enable mouse support
set backspace=indent,eol,start  " Make backspace work as expected
set ignorecase                  " Case insensitive search
set smartcase                   " Unless capital letters are used
set hlsearch                    " Highlight search results
set incsearch                   " Incremental search
set expandtab                   " Use spaces instead of tabs
set shiftwidth=4                " Indent width
set tabstop=4                   " Tab width
set smartindent                 " Auto indent
set nowrap                      " Don't wrap lines
set cursorline                  " Highlight current line
set scrolloff=8                 " Keep 8 lines visible when scrolling

" Enable 24-bit true color support
if has('termguicolors')
    set termguicolors
endif

syntax on                       " Enable syntax highlighting

" Paste toggle - press F2 to toggle paste mode
set pastetoggle=<F2>
 
" Use system clipboard on local machine
set clipboard=unnamed

" Show paste mode in status line
set showmode

" Color scheme
set background=dark

" Auto-switch theme based on macOS system appearance
function! SetThemeFromSystem()
    if has('macunix')
        let l:mode = system('defaults read -g AppleInterfaceStyle 2>/dev/null')
        if l:mode =~# 'Dark'
            try
                colorscheme carbonfox
            catch
                colorscheme slate
            endtry
        else
            try
                colorscheme dayfox
            catch
                colorscheme slate
            endtry
        endif
    else
        " Default to carbonfox on non-macOS systems
        try
            colorscheme carbonfox
        catch
            colorscheme slate
        endtry
    endif
endfunction

" Set theme after plugins are loaded
augroup SetColorscheme
    autocmd!
    autocmd VimEnter * call SetThemeFromSystem()
augroup END

" Clear search highlighting with Esc
nnoremap <Esc> :nohlsearch<CR>

" Leader key
let mapleader = " "
