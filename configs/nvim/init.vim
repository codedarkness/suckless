source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/vim-plug/plugins.vim

" Status line color scheme
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \}

" Some Colors
highlight LineNr        ctermfg=8   ctermbg=none   cterm=none
highlight Number        ctermfg=1   ctermbg=none   cterm=none
highlight VertSplit     ctermfg=8   ctermbg=8      cterm=none
highlight Statement     ctermfg=2   ctermbg=none   cterm=none
highlight Directory     ctermfg=4   ctermbg=none   cterm=none
highlight Comment       ctermfg=4   ctermbg=none   cterm=none
highlight Constant      ctermfg=12  ctermbg=none   cterm=none
highlight Special       ctermfg=4   ctermbg=none   cterm=none
highlight Identifier    ctermfg=6   ctermbg=none   cterm=none
highlight PreProc       ctermfg=5   ctermbg=none   cterm=none
highlight String        ctermfg=12  ctermbg=none   cterm=none
highlight Function      ctermfg=1   ctermbg=none   cterm=none

" Modal Window colors
highlight Pmenu         ctermfg=none    ctermbg=none  cterm=none
