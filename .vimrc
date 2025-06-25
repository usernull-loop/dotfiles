set nocompatible
filetype on

" ============================================================================
"                         PLUGIN MANAGER (vim-plug)
" ============================================================================
call plug#begin('~/.vim/plugged')

" Theme
Plug 'morhetz/gruvbox'

" File Explorer
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Markdown editing enhancements
Plug 'plasticboy/vim-markdown'         " Better Markdown syntax
Plug 'godlygeek/tabular'               " Table formatting (used by vim-markdown)
Plug 'junegunn/goyo.vim'               " Distraction-free writing
Plug 'junegunn/limelight.vim'          " Focus writing

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Commenting
Plug 'tpope/vim-commentary'

" Word motion for better sentence navigation
Plug 'chaoren/vim-wordmotion'

" Table of Contents
Plug 'mzlogin/vim-markdown-toc'

" Hex codes as color
Plug 'chrisbra/Colorizer'

call plug#end()

" ============================================================================
"                         UI & THEME
" ============================================================================
syntax enable
set background=dark
colorscheme hemisu
highlight NonText guifg=#5C6A72 ctermfg=243
set number
set relativenumber
set wrap
set linebreak
set textwidth=80
set showbreak=↪\
set cursorline
set signcolumn=no
set showmatch
set noswapfile

" ============================================================================
"                         MARKDOWN & WRITING SETTINGS
" ============================================================================
set clipboard=unnamedplus
set encoding=utf-8
set conceallevel=2

" Indentation
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent

" Vim-Markdown
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

" vim-markdown-toc
let g:vmt_auto_update_on_save = 1
let g:vmt_fence_text = 'TOC'

" Limelight color configuration
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = '#777777'
" ============================================================================
"                         AUTOCMDS
" ============================================================================

" Set markdown-specific settings
autocmd FileType markdown setlocal spell wrap linebreak conceallevel=2
autocmd FileType markdown nnoremap <leader>t :GenTocGFM<CR>

" Enable Goyo + Limelight on markdown
autocmd FileType markdown Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" ============================================================================
"                         KEYBINDINGS
" ============================================================================
let mapleader = ","

" File Explorer
nnoremap <leader>n :NERDTreeToggle<CR>

" Toggle Goyo (distraction-free)
nnoremap <leader>z :Goyo<CR>

" Commenting
nnoremap gc :Commentary<CR>
vnoremap gc :Commentary<CR>

" Generate Markdown TOC
nnoremap <leader>t :GenTocGFM<CR>

nnoremap <F5> :set spell! spelllang=en_us<CR>
nnoremap <leader>ln :set number! relativenumber!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
inoremap jj <Esc>
vnoremap jj <Esc>
nnoremap <Space> :


" Better navigation (wordmotion)
let g:wordmotion_prefix = '<Leader>'

" ============================================================================
"                         OTHER SETTINGS
" ============================================================================
set updatetime=300
set timeoutlen=500
set lazyredraw
set ttyfast
autocmd FileType markdown,css,html,json,yaml,text ColorHighlight


" Trim trailing whitespace before save
autocmd BufWritePre * :%s/\s\+$//e

" ============================================================================
"                         STATUSLINE
" ============================================================================
set noshowmode
set laststatus=2


" Custom mode display
function! MyMode()
  let l:mode = mode()
  return l:mode ==# 'n' ? ' NORMAL ' :
        \ l:mode ==# 'i' ? ' INSERT ' :
        \ l:mode ==# 'v' ? ' VISUAL ' :
        \ l:mode ==# 'V' ? ' V-LINE ' :
        \ l:mode ==# 'R' ? ' REPLACE ' :
        \ l:mode
endfunction

" Highlight groups for terminal
highlight StatusMode   ctermfg=107 ctermbg=0 cterm=bold
highlight StatusLine   ctermfg=250 ctermbg=0 cterm=NONE
highlight StatusLineNC ctermfg=240 ctermbg=0 cterm=NONE

" Set the statusline
set statusline=%#StatusMode#
set statusline+=%{MyMode()}
set statusline+=%#StatusLine#
set statusline+=\ %<%f\               " File path
set statusline+=%m                    " [+] if modified
set statusline+=%=                    " Right-align from here
set statusline+=%y                    " Filetype
set statusline+=\ \|\ %{wordcount().words}w
set statusline+=\ \|\ line:\ %l
set statusline+=\ \|\ col:\ %c

