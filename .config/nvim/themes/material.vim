filetype plugin indent on    " required
syntax on

if (has('termguicolors'))
  set termguicolors
endif

" for dark version
set background=dark

let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'
colorscheme material

" Airline powerline fonts fix
let g:airline_powerline_fonts = 1

let g:airline_theme = 'powerlineish'
