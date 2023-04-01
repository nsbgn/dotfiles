-- Automatically install Packer plugin manager
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

vim.api.nvim_set_keymap(
  't', '<Esc>', '<C-\\><C-n>', {noremap = true})

vim.fn.sign_define("DiagnosticSignError",
  {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",
  {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",
  {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",
  {text = "", texthl = "DiagnosticSignHint"})

require('packer').startup(function(use)
  use 'https://github.com/wbthomason/packer.nvim'
  use 'https://github.com/neovim/nvim-lspconfig'
  -- use 'https://github.com/nvim-treesitter/nvim-treesitter'

-- See recipes at:
-- <https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes>
-- <https://github.com/nvim-telescope/telescope.nvim/issues/791> For ordering 
-- buffers
use {
  'https://github.com/nvim-telescope/telescope.nvim', branch = '0.1.x',
  requires = { {'https://github.com/nvim-lua/plenary.nvim'} },
  config = function()

    require('telescope').setup{
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
          height = 0.6,
        },
        border = true,
        sorting_strategy = "ascending",
        mappings = {
          i = { ["<Esc>"] = require('telescope.actions').close }
        },
        prompt_prefix = "🔍 ",
      },
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
        },
      }
    }

    local builtin = require('telescope.builtin')
    local project_files = function()
      local opts = {}
      vim.fn.system('git rev-parse --is-inside-work-tree')
      if vim.v.shell_error == 0 then
        builtin.git_files(opts)
      else
        builtin.find_files(opts)
      end
    end

    vim.keymap.set('n', 'ts', builtin.lsp_document_symbols, {})
    vim.keymap.set('n', 'tf', builtin.find_files, {})
    vim.keymap.set('n', 'tw', builtin.buffers, {})
  end
}
use {
  'https://github.com/cljoly/telescope-repo.nvim',
  requires={'https://github.com/nvim-telescope/telescope.nvim'},
  config=function()
    require('telescope').setup {
      extensions = {
        repo = {
          list = {
            search_dirs={
              "~/work",
              "~/notes",
              "~/projects",
            },
          }
        }
      }
    }
    require("telescope").load_extension "repo"
    vim.keymap.set('n', 'tr', require'telescope'.extensions.repo.list, {})
  end
}
-- use {
--   "https://github.com/nvim-telescope/telescope-frecency.nvim",
--   requires = {"https://github.com/kkharji/sqlite.lua"},
--   config = function()
--     require"telescope".load_extension("frecency")
--     vim.keymap.set('n', 'tf', require('telescope').extensions.frecency.frecency, {})
--   end,
-- }

-- Color scheme ---------------------------------------------------------------

  -- A colorscheme that uses few colors
  use {
    "https://github.com/mcchrish/zenbones.nvim",
    tag = "v2.0.0",
    requires = "https://github.com/rktjmp/lush.nvim",
    config = function ()
      -- vim.g.rosebones_lightness = "bright"
      vim.g.zenwritten_transparent_background = true
      vim.cmd("set termguicolors")
      vim.cmd("set background=light")
      vim.cmd("colorscheme zenwritten")

      -- Further tweaks
      local lush = require "lush"
      local zenbones = require "zenbones"
      local specs = lush.parse(function()
        return {
          -- MsgArea { gui="standout" },
          -- markdownH1 { gui = "underline,bold" },
          -- markdownH1Delimiter { gui = "underline,bold" },
          markdownH2 { gui = "invert" },
          -- markdownH2Delimiter { gui = "underline,bold" },
          pandocAtxHeader { gui = "underline,bold" },
          pandocAtxStart { gui = "underline" },
          pandocOperator { fg = "#666666" },
          yamlBlockMappingKey { gui = "bold" },
          DiffAdd { bg = "none" },
          DiffChange { bg = "none" },
          DiffDelete { bg = "none" },
          Visual { fg = "#cccccc", bg = "#333333" },
          NonText { fg = "#888888" },
        }
      end)

      lush.apply(lush.compile(specs))
    end
  }

-- Distraction-free writing ---------------------------------------------------
  use {
    'https://github.com/folke/zen-mode.nvim',
    config = function()
      require("zen-mode").setup {
        window = {
          width = 82,
          height = 1,
          options = {
           signcolumn = "yes", -- keep signcolumn
           -- number = false, -- disable number column
           -- relativenumber = false, -- disable relative numbers
           -- cursorline = false, -- disable cursorline
           -- cursorcolumn = false, -- disable cursor column
           -- foldcolumn = "0", -- disable fold column
           -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = true, -- disables the ruler text in the cmd line area
            showcmd = true, -- disables the command in the last line of the screen
          },
          -- twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          -- gitsigns = { enabled = false }, -- disables git signs
          -- tmux = { enabled = false }, -- disables the tmux statusline
        },
        -- cf <https://github.com/folke/zen-mode.nvim/issues/35>
        on_open = function(_)
          vim.cmd 'cabbrev <buffer> q let b:quitting = 1 <bar> q'
          vim.cmd 'cabbrev <buffer> wq let b:quitting = 1 <bar> wq'
        end,
        on_close = function()
          if vim.b.quitting == 1 then
            vim.b.quitting = 0
            vim.cmd 'q'
          end
        end,
      }
    end
  }

-- Moving around. Comfortable middle ground between hop and sneak -------------
  use {
    'https://github.com/ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
      require('leap').opts.highlight_unlabeled_phase_one_targets = true

      -- So that the first match in leap.nvim is shown
      -- See https://github.com/ggandor/leap.nvim/issues/27
      vim.cmd([[ highlight Cursor ctermbg=White ctermfg=Black ]])
    end
  }

  use {
    'https://github.com/ggandor/flit.nvim',
    config = function()
      require('flit').setup()
    end
  }

-- Scrolling ------------------------------------------------------------------
  -- Scrollbar
  -- use 'https://github.com/dstein64/nvim-scrollview'

  -- Inertial scroll
  -- use {
  --   'https://github.com/karb94/neoscroll.nvim',
  --   config = function()
  --     require('neoscroll').setup({
  --         -- All these keys will be mapped to their corresponding default scrolling animation
  --         mappings = {}, --'<C-u>', '<C-d>', '<C-b>', '<C-f>'
  --         hide_cursor = true,          -- Hide cursor while scrolling
  --         stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  --         respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  --         cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  --         easing_function = "sine",-- Default easing function
  --         pre_hook = nil,              -- Function to run before the scrolling animation starts
  --         post_hook = nil,             -- Function to run after the scrolling animation ends
  --         performance_mode = false,
  --     })

  --     local t = {}
  --     t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
  --     t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}}
  --     t['<C-y>'] = {'scroll', {'-0.20', 'false', '100'}}
  --     t['<C-e>'] = {'scroll', { '0.20', 'false', '100'}}
  --     t['<PageUp>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '400'}}
  --     t['<PageDown>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '400'}}
  --     require('neoscroll.config').set_mappings(t)
  --     -- vim.cmd("map <PageUp> <C-b>")
  --     -- vim.cmd("map <PageDown> <C-f>")
  --   end
  -- }

-- Set working directory to project root --------------------------------------
  use {
    'https://github.com/airblade/vim-rooter.git',
    config = function()
      vim.cmd([[
        let g:rooter_silent_chdir = 1
        let g:rooter_change_directory_for_non_project_files = 'current'
        let g:rooter_resolve_links = 1
        let g:rooter_patterns = ['.git', 'Makefile']
      ]])
    end
  }

-- Show git/svn changes ------------------------------------------------------
  use {
    'https://github.com/mhinz/vim-signify.git',
    config = function()
      vim.cmd([[
        set signcolumn=auto
        let g:signify_sign_add = '✚'
        let g:signify_sign_delete = '✖'
        let g:signify_sign_delete_first_line = '●'
        let g:signify_sign_change = '✱'
      ]])
      -- highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE
      -- highlight SignifySignAdd ctermfg=Green cterm=NONE
      -- highlight SignifySignDelete ctermfg=DarkRed cterm=NONE
      -- highlight SignifySignChange ctermfg=Magenta cterm=NONE
    end
  }

  -- cf <https://nic-west.com/posts/workman-layout/>
  -- use {
  --   'https://github.com/nicwest/vim-workman',
  --   config = function()
  --     vim.cmd([[
  --       let g:workman_normal_workman = 0
  --       let g:workman_insert_workman = 0
  --       let g:workman_normal_qwerty = 0
  --       let g:workman_insert_qwerty = 0
  --     ]])
  --   end
  -- }

  -- Visually indicate marks
  use 'https://github.com/kshenoy/vim-signature'

  -- Automatically detect indentation
  use 'https://github.com/tpope/vim-sleuth'

  -- More sensible word motions
  use 'https://github.com/chaoren/vim-wordmotion'

  -- Auto comment lines
  use 'https://github.com/tpope/vim-commentary'

  -- Return to last position when editing files
  use 'https://github.com/farmergreg/vim-lastplace'

-- Syntax highlighting --------------------------------------------------------
  use 'https://github.com/niklasl/vim-rdf'
  use 'https://github.com/vito-c/jq.vim'
  use 'https://github.com/ledger/vim-ledger'
  use {
    'https://github.com/dylon/vim-antlr',
    config = function()
      vim.cmd([[
        au BufRead,BufNewFile *.g set filetype=antlr3
        au BufRead,BufNewFile *.g4 set filetype=antlr4
      ]])
    end
  }
  use {
    'https://github.com/vim-pandoc/vim-pandoc-syntax.git',
    config = function()
      vim.cmd([[
        let g:pandoc#syntax#conceal#use=0
      ]])
    end
  }

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
      require('packer').sync()
  end
end)

-- Autocompile Packer config when anything changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
