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

" Use a built-in dark colorscheme that works well in modern terminals
" Options: slate, desert, evening, koehler, murphy, pablo, ron, torte
try
    colorscheme slate
catch
    " If colorscheme fails, just use default
    colorscheme default
endtry

" Optional: Customize a few colors for better readability
if has('termguicolors')
    " Make comments slightly brighter for better visibility
    hi Comment ctermfg=245 guifg=#8b949e
endif

" Clear search highlighting with Esc
nnoremap <Esc> :nohlsearch<CR>

" Leader key
let mapleader = " "
