if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

"---------=== Удобства  ===-------------
Plug 'tpope/vim-commentary'           " Comment stuff out
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'chrisbra/Colorizer'
"---------=== Code/project navigation ===-------------
Plug 'scrooloose/nerdtree'            " A tree explorer plugin for vim
Plug 'majutsushi/tagbar'              " Class/module browser
"------------------=== Other ===----------------------
Plug 'vim-airline/vim-airline'        " Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes'
Plug 'rosenfeld/conque-term'          " Consoles as buffers
Plug 'tpope/vim-surround' 

"---------------=== Languages support ===-------------
Plug 'scrooloose/syntastic'           " Syntax checking plugin for Vim
Plug 'zxqfl/tabnine-vim'
Plug 'mitsuhiko/vim-sparkup'          " Sparkup (XML/jinja/htlm-django/etc.) support
Plug 'ekalinin/dockerfile.vim'
Plug 'Firef0x/PKGBUILD'
Plug 'jiangmiao/auto-pairs'
" --- Python ---
Plug 'klen/python-mode'               " Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box
Plug 'mitsuhiko/vim-jinja'            " Jinja support for vim
Plug 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim
Plug 'jmcantrell/vim-virtualenv'      " Virtualenv support in VIM
call plug#end()

filetype on
filetype plugin on
filetype plugin indent on

"=====================================================
" General settings
"=====================================================
" Тема
"let g:solarized_termcolors=256
colorscheme solarized
set background=dark
" Swap
set nobackup       ""#no backup files
set nowritebackup  ""#xonly in case you don't want a backup file while editing
set noswapfile
set backspace=indent,eol,start
" This must happen before the syntax system is enabled
aunmenu Help.
let no_buffers_menu=1
set mousemodel=popup

" Activate a permanent ruler and add line highlightng as well as numbers.
" Also disable the sucking pydoc preview window for the omni completion
" and highlight current line and disable the blinking cursor.
set ruler
set completeopt-=preview
set gcr=a:blinkon0
if has("gui_running")
    set cursorline
endif
set ttyfast

" set guifont=Consolas:h13
"#set guifont=DejaVu\Sans\Mono\for\Powerline:h12
set guifont=ubuntu

" Enable Syntax Colors
" in GUI mode we go with fruity and Monaco 13
" in CLI mode myterm looks better (fruity is GUI only)
syntax on
if has("gui_running")
    set macmeta " comment this line if you're not using Mac OS
    set lines=50 columns=125
endif
" special settings for vim
if has("mac")
    let macvim_hig_shift_movement = 1
endif

tab sball
set switchbuf=useopen

" Use system clipboard
set clipboard=unnamedplus

" Customize the wildmenu
set wildmenu
set wildignore+=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class,*/*.dSYM/*,*.dylib
set wildmode=list:full
" Don't bell and blink
set visualbell t_vb=    " turn off error beep/flash
set enc=utf-8           " utf-8 default encoding
set ls=2                " always show status bar
set incsearch           " incremental search
set hlsearch            " highlighted search results
set nu                  " line numbers
set scrolloff=5         " keep some more lines for scope
set showmatch           " show matching brackets/parenthesis
set matchtime=0         " don't blink when matching

" Swaps and backups
if has("win32") || has("win64")
    set dir=$TMP
    set backupdir=$TMP
else
    set dir=/tmp
    set backupdir=/tmp
endif

" Hide some panels
"set guioptions-=m  " remove menu bar
set guioptions-=T   " remove toolbar
"set guioptions-=r  " remove right-hand scroll bar

" Tab Settings

" Highlight characters past column 120
augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=#c12a0f
    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END

" SnipMate settings
let g:snippets_dir = "~/.vim/vim-snippets/snippets"

"NERDTree
map <F1> :NERDTreeToggle<CR>    " browse the list of files in the current directory

nmap <F8> :TagbarToggle<CR>



" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
noremap <f7> :w<CR>:SyntasticCheck<CR>

" Better :sign interface symbols
let g:syntastic_error_symbol = 'X'
let g:syntastic_style_error_symbol = 'X'
let g:syntastic_warning_symbol = 'x'
let g:syntastic_style_warning_symbol = 'x'

" Vim-Airline
"let g:airline_theme='powerlineish'
let g:airline_theme="deus"

"=====================================================
" Python-mode settings
"=====================================================
" Python-mode
" Activate rope
" Keys:
" K Show python docs
" <Ctrl-Space> Rope autocomplete
" <Ctrl-c>g Rope goto definition
" <Ctrl-c>d Rope show documentation
" <Ctrl-c>f Rope find occurrences
" <Leader>b Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[ Jump on previous class or function (normal, visual, operator modes)
" ]] Jump on next class or function (normal, visual, operator modes)
" [M Jump on previous class or method (normal, visual, operator modes)
" ]M Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0
"Удобство 
nnoremap ^ :
" запуск питон скриптов на F5
autocmd FileType python nnoremap <buffer> <F5> :exec '!clear;python %' shellescape(@%, 1)<cr>
" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
"Linting
let g:pymode_lint = 1
"let g:pymode_lint_checkers = ['pylint', 'pep8']
let g:pymode_lint_cwindow = 1
let g:pymode_lint_ignore="E501,W601,C0110,C0111"
let g:pymode_lint_write = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" Syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Get possibility to run Python code
let g:pymode_run = 0

" Other options
let g:pymode_options_colorcolumn = 0
if has("gui_running")
    let g:airline_powerline_fonts = 1
else
    let g:airline_powerline_fonts = 0
endif

"=====================================================
" User hotkeys
"=====================================================
" Easier moving of code blocks
vnoremap < <gv " Shift+> keys
vnoremap > >gv " Shift+< keys

" Backspace in Visual mode deletes selection
vnoremap <BS> d
map <C-n> :NERDTreeToggle<CR> 
" CTRL-Z is Undo
noremap <C-z> u
inoremap <C-z> <C-O>u

" CTRL-Y is Redo
noremap <C-y> <C-R>
inoremap <C-y> <C-O><C-R>

" CTRL-A is Select all
noremap <C-a> gggH<C-O>G
inoremap <C-a> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-a> <C-C>gggH<C-O>G
onoremap <C-a> <C-C>gggH<C-O>G
snoremap <C-a> <C-C>gggH<C-O>G
xnoremap <C-a> <C-C>ggVG

" CTRL-S is Quicksave command
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>

" Settings for buffers
map <C-q> :bd<CR>         " close current buffer
noremap <C-Right> :bn<CR> " move to next buffer
noremap <C-Left> :bp<CR>  " move to previous buffer

" Easier split navigations
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Easier change size for splitted windows
nnoremap <M-[> :vertical resize +5<cr>
nnoremap <M-]> :vertical resize -5<cr>

" Activate autocomplete at <Ctrl+Space>
inoremap <C-space> <C-x><C-o>

" Generate and insert UUID4 into code by <F12> key
nnoremap <F6> :call InsertUUID4()<CR>

" Python code check on PEP8
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>




" --- Python ---
let python_highlight_all=1
let python_highlight_exceptions=0
let python_highlight_builtins=0
let python_slow_sync=1
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent 
let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_python_flake8_args='--ignore=E121,E128,E711,E301,E261,E241,E124,E126,E721\ --max-line-length=80'
" --- Vim ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
" --- template language support (SGML / XML too) ---
autocmd FileType xml,html,htmljinja,htmldjango setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html,htmljinja,htmldjango imap <buffer> <c-e> <Plug>SparkupExecute
autocmd FileType html,htmljinja,htmldjango imap <buffer> <c-l> <Plug>SparkupNext
autocmd FileType htmljinja setlocal commentstring={#\ %s\ #}
let html_no_rendering=1
let g:syntastic_html_checkers = []

"=====================================================
" User functions
"=====================================================
" Small helper that inserts a random uuid4
" ----------------------------------------
function! InsertUUID4()
python << endpython
if 1:
    import uuid, vim
    s = str(uuid.uuid4())
    cpos = vim.current.window.cursor
    cline = vim.current.line
    vim.current.line = cline[:cpos[1] + 1] + s + cline[cpos[1] + 1:]
    vim.current.window.cursor = (cpos[0], cpos[1] + len(s))
endpython
endfunction
set noerrorbells
set vb t_vb=
set t_Co=256
