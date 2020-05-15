call plug#begin('~/.vim/plugged')

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'Yggdroot/indentLine' 
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'vimwiki/vimwiki'
Plug 'chrisbra/csv.vim'
Plug 'jpalardy/vim-slime'
Plug 'Chiel92/vim-autoformat'
Plug 'lervag/vimtex'
Plug 'tmsvg/pear-tree'
Plug 'machakann/vim-sandwich'
Plug 'vim-airline/vim-airline'
Plug 'inside/vim-search-pulse'
Plug 'easymotion/vim-easymotion'

call plug#end()

" fzf floating window
let g:fzf_layout = { 'window': {
                \ 'width': 0.9,
                \ 'height': 0.7,
                \ 'highlight': 'Comment',
                \ 'rounded': v:false } }

nnoremap <c-o> :BLines<CR>
nnoremap <c-l> :Lines<CR>
nnoremap <c-p> :Files<CR>

" vimtex
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_view_method = 'skim'

let mapleader="\<Space>" 

" " latex minted
" let g:vimtex_compiler_latexmk = {
"     \ 'options' : [
"     \   '-pdf',
"     \   '-shell-escape',
"     \   '-verbose',
"     \   '-file-line-error',
"     \   '-synctex=1',
"     \   '-interaction=nonstopmode',
"     \ ],
"     \}

" NCM2
augroup NCM2
  autocmd!
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()
  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect
  " uncomment this block if you use vimtex for LaTex
  autocmd Filetype tex call ncm2#register_source({
            \ 'name': 'vimtex',
            \ 'priority': 8,
            \ 'scope': ['tex'],
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
augroup END

" Tab to select autocomplete, Shift-Tab to reverse
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enter will always newline
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Ignore hidden files 
let g:dirvish_mode = ':silent keeppatterns g@\v/\.[^\/]+/?$@d _'

" Enable going down in case text is wrapped
nnoremap j gj
nnoremap k gk

" scrolling
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" buffers
nnoremap <C-d> :bprev<CR>
nnoremap <C-u> :bnext<CR>
nnoremap <C-w> :bd<CR> 
nnoremap <C-n> :enew<CR> 

" esc and : remaps
inoremap jj <ESC>
nnoremap <leader>h :noh<CR>
nnoremap q :

" unbind ex mode
map Q <Nop>

" easy motion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap f <Plug>(easymotion-overwin-f2)
nnoremap <leader>f f

set nu
set ts=4
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set showmatch
set hlsearch
set shortmess+=c
set ignorecase
set smartcase
set mouse+=a
set title
set clipboard=unnamed
set laststatus=0
set hidden
set scrolloff=3
filetype plugin on
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Markdown code blocks
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:vimwiki_list = [{'path': '~/vimwiki/',
                     \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" Run cell for vim-slime
" Enclose with # %%
function! SendCell(pattern)
    let start_line = search(a:pattern, 'bnW')

    if start_line
        let start_line = start_line + 1
    else
        let start_line = 1
    endif

    let stop_line = search(a:pattern, 'nW')
    if stop_line
        let stop_line = stop_line - 1
    else
        let stop_line = line('$')
    endif

    call slime#send_range(start_line, stop_line)
endfunction

" Custom vim-slime mappings
let g:slime_no_mappings = 1
xmap <c-c><c-c> <Plug>SlimeRegionSend
nmap <c-c><c-c> <Plug>SlimeParagraphSend
nmap <leader>j :<c-u>call SendCell('^#.\+%%')<cr>
nmap <leader>c <Plug>SlimeLineSend
let g:slime_target = "tmux"
" tmux:
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1

" wrap markdown at 80 char
au BufRead,BufNewFile *.md setlocal textwidth=80

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline_disable_statusline = 1
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

nmap <silent> <leader>1 <Plug>AirlineSelectTab1
nmap <silent> <leader>2 <Plug>AirlineSelectTab2
nmap <silent> <leader>3 <Plug>AirlineSelectTab3
nmap <silent> <leader>4 <Plug>AirlineSelectTab4
nmap <silent> <leader>5 <Plug>AirlineSelectTab5
nmap <silent> <leader>6 <Plug>AirlineSelectTab6
nmap <silent> <leader>7 <Plug>AirlineSelectTab7
nmap <silent> <leader>8 <Plug>AirlineSelectTab8
nmap <silent> <leader>9 <Plug>AirlineSelectTab9

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary ctermfg=9 cterm=underline
augroup END

" Set colorscheme
colorscheme ron
hi Operator ctermfg=yellow
hi PmenuSel ctermfg=lightgrey
hi Pmenu ctermbg=229 ctermfg=234
hi Comment ctermfg=147

let g:vim_search_pulse_duration = 100

