let mapleader = " "

autocmd!
set nocompatible

filetype off
filetype plugin on
filetype indent on
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

au BufWritePost .vimrc so $MYVIMRC

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'KurtPreston/vim-autoformat-rails'
Plugin 'ervandew/supertab'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-rbenv'
Plugin 'benmills/vimux'
Plugin 'jgdavey/vim-turbux'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'yegappan/mru'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'alvan/vim-closetag'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'roman/golden-ratio'
Plugin 'tmhedberg/matchit'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-obsession'

" All of your Plugins must be added before the following line
call vundle#end()

let test#strategy = "vimux"

"Stop hightling search words
nnoremap <leader><space> :nohlsearch<CR>

"key word search
nnoremap <leader>a :Find
noremap <leader>z :grep <cword> *<CR>
nnoremap <leader>ar  :Ag! G ".*.rb"'
"open related file in vertical split
nnoremap <leader>b :AV<CR>

"remove trailing whitespace on save
autocmd BufWritePre * StripWhitespace

"testing
let g:turbux_command_prefix = 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec'
let g:turbux_runner  = 'vimux'
map <Leader>qq :VimuxCloseRunner<CR>
" hack to fix broken 'run focused test' since
" https://github.com/jgdavey/vim-turbux/pull/36
let g:turbux_test_type = ''

"open a console pan
map <Leader>d :VimuxPromptCommand("dev c ")<CR><CR>

"start fuzzy finder
map <leader>f :Files<CR>

"moving lines
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"ctags
nnoremap <leader>. <C-]>

nnoremap ' "
"gitgutter
nmap <leader>] <Plug>GitGutterNextHunk
nmap <leader>[ <Plug>GitGutterPrevHunk

nmap <Leader>h <Plug>GitGutterStageHunk
nmap <Leader>hh <Plug>GitGutterUndoHunk

"colourscheme
"set t_Co=256
let base16colorspace=256  " Access colors present in 256 colorspace
"let g:solarized_termcolors=256
syntax enable
"set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme base16-atelier-plateau
let g:airline_powerline_fonts = 1
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

"toggle nerdtree
map <leader>n :NERDTreeToggle<CR>

"save and quit
map <leader>s :w<CR>
map <leader>q :q<CR>

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
command! -bang -nargs=* Find call fzf#vim#grep('rg --line-number --fixed-strings --ignore-case --color "always" '.shellescape(<q-args>), 0, <bang>0)


imap <c-x><c-l> <plug>(fzf-complete-line)
" Better command history with q:
command! CmdHist call fzf#vim#command_history()
nnoremap <leader>fh :CmdHist<CR>

" Better search history
command! FileHist call fzf#vim#history()
nnoremap <leader>ff :FileHist<CR>

"source vim file
nnoremap <leader>sv :source $MYVIMRC<cr>
