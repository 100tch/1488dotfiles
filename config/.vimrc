syntax enable

call plug#begin()
" fzf.vim github: https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf.vim'
" vimwiki github: https://github.com/vimwiki/vimwiki 
Plug 'vimwiki/vimwiki'
" vim-java-unused-imports github: https://github.com/akhaku/vim-java-unused-imports 
Plug 'akhaku/vim-java-unused-imports'
call plug#end()

" Indentation and tabulation
set tabstop=8 	"8 default"
set shiftwidth=8
set autoindent

" Show line numbers
set nu

" Disabling a backup file
set nobackup
set noswapfile

" Additional settings
set ruler
set confirm
set encoding=utf8
set hlsearch
set incsearch
set title

let g:vimwiki_list = [{"path": "~/.local/vimwiki/"}]
