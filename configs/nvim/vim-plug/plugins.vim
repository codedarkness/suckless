" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'ryanoasis/vim-devicons'
	Plug 'plasticboy/vim-markdown'
	Plug 'othree/html5.vim'
	Plug 'stanangeloff/php.vim'
	Plug 'hdima/python-syntax'
	Plug 'cespare/vim-toml'
	Plug 'cakebaker/scss-syntax.vim'
	Plug 'gregsexton/matchtag'
	Plug 'elzr/vim-json'
	Plug 'itchyny/lightline.vim'
	Plug 'francoiscabrol/ranger.vim'
	"Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
	"Plug 'vimwiki/vimwiki'
	Plug 'sirver/ultisnips'
	Plug 'ap/vim-css-color'
	Plug 'preservim/nerdcommenter'
	Plug 'tpope/vim-surround'
	Plug 'dense-analysis/ale'
	Plug 'frazrepo/vim-rainbow'
	Plug 'neovimhaskell/haskell-vim'
	Plug 'scrooloose/vim-fugitive'
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
call plug#end()
