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

------------------------------------------------------------------------------




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
  use 'https://github.com/nvim-treesitter/nvim-treesitter'
  use {
   'https://github.com/nvim-treesitter/playground',
    config = function()
      require "nvim-treesitter.configs".setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  }

  -- Integrate direnv; see <https://direnv.net/>
  use 'https://github.com/direnv/direnv.vim'

  -- Visually indicate marks
  use 'https://github.com/kshenoy/vim-signature'

  -- Automatically detect indentation
  use 'https://github.com/tpope/vim-sleuth'

  -- More sensible word motions
  use 'https://github.com/chaoren/vim-wordmotion'

  -- Auto comment lines
  use {
    "https://github.com/tpope/vim-commentary",
    config = function()
      vim.cmd[[
      autocmd FileType turtle setlocal commentstring=#\ %s
      ]]
    end
  }

  -- Return to last position when editing files
  use 'https://github.com/farmergreg/vim-lastplace'

  -- Alternatively, see <https://github.com/akinsho/toggleterm.nvim>
  use {
    "https://github.com/numToStr/FTerm.nvim",
    config = function()
      local ft = require'FTerm'
      ft.setup({
        border = 'rounded',
        dimensions  = {
            height = 0.9,
            width = 84,
        },
      })
      vim.keymap.set('n', 'tt', ft.toggle, {})
      vim.keymap.set('n', '<C-t>', ft.toggle, {})
      vim.keymap.set('t', '<C-t>', ft.toggle, {})
      vim.api.nvim_set_keymap(
        't', '<C-Esc>', '<C-\\><C-n>', {noremap = true})
    end
  }

-- See recipes at:
-- <https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes>
use {
  'https://github.com/nvim-telescope/telescope.nvim', branch = '0.1.x',
  requires = { {'https://github.com/nvim-lua/plenary.nvim'} },
  config = function()

    require('telescope').setup{
      defaults = {
        layout_strategy = "vertical",
        file_ignore_patterns = { ".git/" },
        layout_config = {
          mirror = true,
          prompt_position = "top",
          height = 0.95,
          width = 84,
          preview_height = 10
        },
        border = true,
        sorting_strategy = "ascending",
        mappings = {
          i = { ["<Esc>"] = require('telescope.actions').close }
        },
        prompt_prefix = "🔍 ",
      },
      pickers = {
        -- Order: <https://github.com/nvim-telescope/telescope.nvim/issues/791>
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
        },
      }
    }

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', 'ts', builtin.lsp_document_symbols, {})
    -- vim.keymap.set('n', 'tf', builtin.find_files, {})
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
            bin = {
              "/usr/bin/fdfind"
            },
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
use {
    "https://github.com/nvim-telescope/telescope-file-browser.nvim",
    requires = {
      "https://github.com/nvim-telescope/telescope.nvim",
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-tree/nvim-web-devicons"
    },
    config = function()

      local action_state = require "telescope.actions.state"
      local fb_actions = require "telescope".extensions.file_browser.actions
      local fb_utils = require "telescope._extensions.file_browser.utils"

      --- If the prompt is empty, goes to parent directory.
      local backward = function(prompt_bufnr, bypass)
        local current_picker = action_state.get_current_picker(prompt_bufnr)

        if current_picker:_get_prompt() == "" then
          fb_actions.goto_parent_dir(prompt_bufnr, bypass)
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<left>", true, false, true), "tn", false)
        end
      end

      --- If the prompt is empty and the selection is a directory, enter it.
      local forward = function(prompt_bufnr, bypass)
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local entry_path = action_state.get_selected_entry().Path
        local finder = current_picker.finder
        local current_dir = finder.path

        if current_picker:_get_prompt() == "" and entry_path:is_dir() then
          finder.path = entry_path:absolute()
          fb_utils.redraw_border_title(current_picker)
          -- fb_utils.selection_callback(current_picker, current_dir)
          current_picker:refresh(
            finder, {
              new_prefix = fb_utils.relative_path_prefix(finder),
              reset_prompt = true, multi = current_picker._multi }
          )
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<right>", true, false, true), "tn", false)
        end
      end

      require("telescope").setup {
        extensions = {
          file_browser = {
            hijack_netrw = true,
            respect_gitignore = true,
            grouped = true,
            dir_icon = "📁︎",
            hide_parent_dir = true,
            hidden = true,
            path = "%:p:h",
            display_stat = false,
            select_buffer = true,
            mappings = {
              ["i"] = {
                -- ["<C-h>"] = fb_actions.goto_cwd,
                ["<left>"] = backward,
                ["<right>"] = forward,
                -- ["<backspace>"] = fb_actions.open,
              },
              ["n"] = {
              },
            },
          },
        },
      }

      require"telescope".load_extension("file_browser")
      vim.keymap.set('n', 'tf',
        require('telescope').extensions.file_browser.file_browser, {})
  end,
}

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
          markdownH1 { gui = "underline,bold" },
          Title { gui = "underline,bold" },
          -- markdownH1Delimiter { gui = "underline,bold" },
          markdownH2 { gui = "invert" },
          -- markdownH2Delimiter { gui = "underline,bold" },
          pandocAtxHeader { fg = "red", gui = "underline,bold" },
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

  use {
    "https://github.com/folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
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
            ruler = true,
            showcmd = true,
          },
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

      vim.cmd([[
        " autocmd VimEnter *.md,*.tex nested :ZenMode
      ]])
    end
  }

-- Moving around --------------------------------------------------------------

-- Comfortable middle ground between hop and sneak
  use {
    'https://github.com/ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
      require('leap').opts.highlight_unlabeled_phase_one_targets = true

      -- So that the first match in leap.nvim is shown
      -- See https://github.com/ggandor/leap.nvim/issues/27
      vim.cmd([[ highlight Cursor ctermbg=White ctermfg=Black ]])

      --vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#777777' })
    end
  }

  -- 'f' motion using the leap interface
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

-- Git -----------------------------------------------------------------------

  -- use {
  --     'https://github.com/nvim-treesitter/nvim-treesitter',
  --     run = ':TSUpdate'
  -- }
-- use {
--   'https://github.com/sindrets/diffview.nvim'
-- }
  -- use {
  --   'https://github.com/TimUntersberger/neogit',
  --   requires = 'https://github.com/nvim-lua/plenary.nvim'
  -- }
-- use {
--   'https://github.com/tpope/vim-fugitive'
-- }
-- use {
--   'https://github.com/lewis6991/gitsigns.nvim'
-- }
-- use {
--   'https://github.com/tanvirtin/vgit.nvim',
--   requires = {
--     'https://github.com/nvim-lua/plenary.nvim'
--   }
-- }

  -- Works for both git and svn
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

-- Tests ---------------------------------------------------------------------

-- use {
--   'https://github.com/klen/nvim-test',
--   requires = {
--     "https://github.com/nvim-lua/plenary.nvim",
--     "https://github.com/nvim-treesitter/nvim-treesitter",
--   },
--   config = function()
--     require('nvim-test').setup()
--   end
-- }
-- use {
--   'https://github.com/vim-test/vim-test'
-- }
-- vim.cmd([[let g:ultest_deprecation_notice = 0]])
-- use {
--   "https://github.com/rcarriga/vim-ultest",
--   requires = {"https://github.com/vim-test/vim-test"},
--   run = ":UpdateRemotePlugins",
--   config = function()
--   end
-- }
use {
  "https://github.com/nvim-neotest/neotest",
  requires = {
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/antoinemadec/FixCursorHold.nvim",
    "https://github.com/nvim-neotest/neotest-python",
    "https://github.com/rouge8/neotest-rust"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        -- require("neotest-python")({
        --   dap = { justMyCode = false },
        -- }),
        -- require("neotest-plenary"),
        -- require("neotest-vim-test")({
        --   ignore_file_types = { "python", "vim", "lua" },
        -- }),
      },
    })

    local nt = require("neotest")
    vim.keymap.set('n', 'xt', nt.run.run, {})
    vim.keymap.set('n', 'xs', nt.summary.open, {})

  end
}

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

-- Temporary solution after Neovim 0.9.
vim.cmd([[
  autocmd VimEnter * highlight markdownH1 gui=underline,bold
  autocmd VimEnter * highlight markdownH2 gui=underline,bold,italic
  autocmd VimEnter * highlight markdownH3 gui=underline,italic
  autocmd VimEnter * highlight markdownItalic gui=italic
  autocmd VimEnter * highlight markdownItalicDelimiter gui=italic guifg=gray
  autocmd VimEnter * highlight markdownBold gui=bold
  autocmd VimEnter * highlight markdownBoldDelimiter gui=bold guifg=gray
  autocmd VimEnter * highlight markdownCode guibg=#eeeeee
  autocmd VimEnter * highlight markdownAutomaticLink gui=underline
  autocmd VimEnter * highlight DiffAdd guibg=none guifg=lightgreen
  autocmd VimEnter * highlight DiffChange guibg=none guifg=lightblue
  autocmd VimEnter * highlight DiffDelete guibg=none guifg=lightred
  autocmd VimEnter * highlight Visual guifg=#cccccc guibg=#333333
  autocmd VimEnter * highlight NonText guifg=#888888
  autocmd VimEnter * highlight yamlBlockMappingKey gui=bold guifg=gray
  autocmd VimEnter * highlight yamlDocumentStart gui=none guifg=gray
  autocmd VimEnter * highlight LeapBackdrop guifg=gray
  autocmd VimEnter * highlight LeapLabelPrimary guifg=red guibg=white
  autocmd VimEnter * highlight LeapMatch guifg=black guibg=white
]])


