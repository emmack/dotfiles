let mapleader = " "

set encoding=utf-8

autocmd!
set nocompatible

set nobackup
set nowritebackup
set noswapfile
set number
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set incsearch
set hlsearch
set exrc
set autoread
set laststatus=2
set noshowmode
set tags=tags;/

autocmd FileType ruby compiler ruby

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Start plugin manager section
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'
Plug 'chiel92/vim-autoformat'
Plug 'w0rp/ale'
Plug 'roman/golden-ratio'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-rails'
Plug 'benmills/vimux'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/supertab'
Plug 'ianks/vim-tsx'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'derekwyatt/vim-scala'
Plug 'jremmen/vim-ripgrep'
Plug 'leafgarland/typescript-vim'
Plug 'janko/vim-test'
Plug 'morhetz/gruvbox'
Plug 'edkolev/tmuxline.vim'
"Plug 'janx/vim-rubytest'
Plug 'christoomey/vim-tmux-runner'

call plug#end()

"gitgutter
let g:gitgutter_log=1
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

highlight LineNr guibg=NONE

"testing config
let test#strategy = "vimux"
"let g:test#runner_commands = ['Minitest']
"let test#ruby#bundle_exec = 0

"let test#ruby#minitest#executable = 'dev test'

"testing commands
nmap <leader>T :TestNearest<CR>
nmap <leader>t :TestFile<CR>
nmap <leader>tt :TestLast<CR>
map <Leader>qq :VimuxCloseRunner<CR>


"open a console pan
map <Leader>d :VimuxPromptCommand("")<CR><CR>
"map <Leader>t :VimuxPromptCommand("dev test" getcwd())<CR><CR>
"map <Leader>rb :call VimuxRunCommand("clear; dev test " . bufname("%"))<CR>

"key word search
nnoremap <leader>a :Find
nnoremap <leader>z :Find <C-R><C-W><CR>
nnoremap <leader>zz / <C-R><C-W><CR>
"open related file in vertical split
nnoremap <leader>b :AV<CR>
nnoremap <leader>b :AV<CR>

"Stop hightling search words
nnoremap <leader><space> :nohlsearch<CR>

"remove trailing whitespace on save
autocmd BufWritePre * StripWhitespace

"formatting
noremap == :Autoformat<CR>
noremap -= ::AutoformatLine <CR>

"toggle nerdtree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let g:netrw_liststyle=3

"visuals
"autocmd vimenter * ++nested
colorscheme gruvbox
set background=dark
let g:gruvbox_termcolors=256
syntax on

let base16colorspace=256

let g:airline_powerline_fonts = 1

let g:airline_theme='luna'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_highlighting_cache = 0
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#color_template = 'normal'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 0

"save and quit
map <leader>s :w<CR>
map <leader>q :q<CR>

"start fuzzy finder
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, <bang>0)

map <leader>f :Files<CR>
nnoremap <leader>v :GFiles?<CR>

"source vim file
nnoremap <leader>sv :source $MYVIMRC<cr>

let g:ale_set_highlights = 0

"buffer stuff
nnoremap <leader>e :Buffers <CR>

"command! Buffers call fzf#run(fzf#wrap(
"      \ {'source': map(range(1, bufnr('$')), 'bufname(v:val)')}))


set clipboard=unnamed
se mouse+=a

"fzf and rg config
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in
"  the .git/ folder)
" --color: Search color options
"command! -bang -nargs=* Find call fzf#vim#grep('rg --line-number --hidden --fixed-strings --ignore-case --color "always" '.shellescape(<q-args>), 0, <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --type-add "liquid:*.liquid" --type-add "erb:*.erb" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  "let reload_command = printf(command_fmt, '{q}')
  "let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(), a:fullscreen)
endfunction

command! -nargs=* -bang Find call RipgrepFzf(<q-args>, <bang>0)


let $RUBYHOME=$HOME."/.rbenv/versions/2.6.5"
set rubydll=$HOME/.rbenv/versions/2.6.5/lib/libruby.2.6.5.dylib

