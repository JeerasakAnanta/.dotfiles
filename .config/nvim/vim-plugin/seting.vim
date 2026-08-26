" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'


" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }



" vim airline  
Plug 'vim-airline/vim-airline'

" gruvbox  
Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}

" syntastic chek 
" Plug 'scrooloose/syntastic'

" vim Icon
Plug 'ryanoasis/vim-devicons'

" indent line
Plug 'yggdroot/indentline'

"comment 
Plug 'tomtom/tcomment_vim'

" git line 
Plug 'airblade/vim-gitgutter'

" project
Plug 'mhinz/vim-startify'

" " ''" 
Plug 'tpope/vim-surround'

" vim pop-up termail
Plug 'voldikss/vim-floaterm'

Plug 'majutsushi/tagbar'


" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

"nvim 0.5 lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'kabouzeid/nvim-lspinstall'


" nvim-telescope 
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" find file 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'nvim-lua/completion-nvim'

Plug 'prabirshrestha/vim-lsp'


" Initialize plugin system

call plug#end()
