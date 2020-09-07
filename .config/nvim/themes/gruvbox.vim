filetype plugin indent on    " required
syntax on
" gruvbox italic fix (must appear before colorscheme)
let g:gruvbox_italic = 1

" important!!
if has('termguicolors')
  set termguicolors
endif

" for dark version
set background=dark

" set contrast
" this configuration option should be placed before `colorscheme gruvbox-material`
" available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'soft'

colorscheme gruvbox-material
" Airline powerline fonts fix
let g:airline_powerline_fonts = 1
" Airline theme
let g:airline_theme = 'gruvbox_material'