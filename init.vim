set nu
set rnu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set t_Co=256
set mousehide
set mouse=a
set termencoding=utf-8
set novisualbell
set t_vb=
set backspace=indent,eol,start whichwrap+=<,>,[,]
set showtabline=1
set nobackup
set noswapfile
set wrap
set linebreak
set visualbell t_vb=
cd /home/serezha/prog/

call plug#begin()
Plug 'idanarye/breeze.vim'
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'windwp/nvim-autopairs'
Plug 'ryanoasis/vim-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'Pocco81/auto-save.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

nnoremap <silent>    <C-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <C-.> <Cmd>BufferNext<CR>

call plug#end()
" status line
lua << END
require('lualine').setup()
END
  colorscheme gruvbox
" autocloser 
lua << EOF
require("nvim-autopairs").setup {}
EOF
" tabbar
nnoremap <silent>    <C-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <C-.> <Cmd>BufferNext<CR>
" nerdtree
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-d> :NERDTreeToggle<CR>
" terminal
lua require("toggleterm").setup()
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <silent><C-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><C-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
" cmp
lua <<EOF
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) 
      end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-<leader>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
EOF
