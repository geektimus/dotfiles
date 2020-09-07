" --- Auto-install vim-plug if not already installed --- "
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif 

" --- Plugin section --- "
call plug#begin('~/.config/nvim/autoload/plugged')

" Better Comments
Plug 'tpope/vim-commentary'

if exists('g:vscode')
  " Easy motion for VSCode
  Plug 'asvetliakov/vim-easymotion'
else
  " Repeat stuff
  Plug 'tpope/vim-repeat'
  " Surround
  Plug 'tpope/vim-surround'

  " Auto set indent settings
  Plug 'tpope/vim-sleuth'

  " Text Navigation
  Plug 'justinmk/vim-sneak'
  Plug 'unblevable/quick-scope'

  " Add some color
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'luochen1990/rainbow'

  " Cool Icons
  Plug 'ryanoasis/vim-devicons'

  " Closetags
  Plug 'alvan/vim-closetag'

  " --- Status line --- "
  Plug 'vim-airline/vim-airline'
  Plug 'kevinhwang91/rnvimr'
  " FZF
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " --- Theming --- "
  Plug 'sainnhe/gruvbox-material'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }

  " --- Completion and syntax --- "

  " Editing and usability

  " Auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'rhysd/git-messenger.vim'
  " Terminal
  Plug 'voldikss/vim-floaterm'
  " Start Screen
  Plug 'mhinz/vim-startify'
  " Vista
  Plug 'liuchengxu/vista.vim'
  " See what keys do like in emacs
  Plug 'liuchengxu/vim-which-key'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'mattn/emmet-vim'
  " Interactive code
  Plug 'metakirby5/codi.vim'
  " Better Whitespace
  Plug 'ntpeters/vim-better-whitespace'
  " Better tabline
  Plug 'mg979/vim-xtabline'
  " undo time travel
  Plug 'mbbill/undotree'
  " highlight all matches under cursor
  Plug 'RRethy/vim-illuminate'
  " Find and replace
  Plug 'ChristianChiarulli/far.vim'
  " Plug 'brooth/far.vim'
  " Auto change html tags
  Plug 'AndrewRadev/tagalong.vim'
  " Smooth scroll
  Plug 'psliwka/vim-smoothie'
  " Swap windows
  Plug 'wesQ3/vim-windowswap'

  " --- Programming Languages ---

  " Better Syntax Support
  Plug 'sheerun/vim-polyglot'

  "Plug 'davidhalter/jedi-vim'

  " Intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" Initialize plugin system
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif