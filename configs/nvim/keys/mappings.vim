" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>
inoremap ii <Esc>
nnoremap <C-c> <Esc>

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>

" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
nnoremap zz :w<CR>

" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" File Explore
nnoremap EE :Explore<CR>
nnoremap SS :Sexplore<CR>
nnoremap VV :Vexplore<CR>

" Ranger
" nmap <space>r :RnvimrToggle<CR>

" FZF
nnoremap <silent> fi :Files<CR>

" Splits
nnoremap <leader>h :split<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>t :tabnew<CR>

" Reload/source
nnoremap <leader>sv :source $MYVIMRC<CR>

" Spell check for US English
map <leader>e :setlocal spell! spelllang=en_us<CR>

" Spell check for Spanish
map <leader>s :setlocal spell! spelllang=es<CR>

" Insert Date
:map <F5> "=strftime("%a %d %b %Y")<CR>P
