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

require('packer').startup(function(use)
  use 'https://github.com/wbthomason/packer.nvim'
  use 'https://github.com/neovim/nvim-lspconfig'
  -- use 'https://github.com/nvim-lua/plenary.nvim'
  -- use 'https://github.com/nvim-telescope/telescope.nvim'
  -- use 'https://github.com/nvim-treesitter/nvim-treesitter'

-- File browser ---------------------------------------------------------------
-- Ideally, icons that overlap with
-- https://raw.githubusercontent.com/slavfox/Cozette/master/img/charmap.png
-- https://unicode-table.com/en/blocks/geometric-shapes/
  use {
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/kyazdani42/nvim-web-devicons",
      "https://github.com/MunifTanjim/nui.nvim",
    },
    config = function ()
      vim.fn.sign_define("DiagnosticSignError",
        {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn",
        {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo",
        {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint",
        {text = "", texthl = "DiagnosticSignHint"})

      require("neo-tree").setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil , -- use a custom function for sorting files and directories in the tree 
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "", --ﰊ
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖",-- this can only be used in the git_status source
              renamed   = "",-- this can only be used in the git_status source
              -- Status type
              untracked = "◌", --         ★☆✪✭✫ ⚐⚑ ◌○◎◉●◍◇◈◆    
              ignored   = "◎",
              unstaged  = "◉",
              staged    = "●",
              conflict  = "◍",
            }
          },
        },
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = { 
              "add",
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_by_name = {
              ".git"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              ".gitignore",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = false, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
            }
          }
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            }
          }
        }
      })

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end
  }

-- Distraction-free writing ---------------------------------------------------
  use {
    'https://github.com/folke/zen-mode.nvim',
    config = function()
      require("zen-mode").setup {
        window = {
          width = 80,
          height = 1,
          options = {
           -- signcolumn = "no", -- disable signcolumn
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

-- Scrolling ------------------------------------------------------------------
  -- Scrollbar
  use 'https://github.com/dstein64/nvim-scrollview'
  -- Inertial scroll
  use {
    'https://github.com/psliwka/vim-smoothie',
    config = function()
      -- vim.cmd([[
      --   let g:smoothie_no_default_mappings = 1
      --   nnoremap <unique> <PageUp> <cmd>call smoothie#do("\<C-U>") <CR>
      --   nnoremap <unique> <PageDown> <cmd>call smoothie#do("\<C-D>") <CR>
      --   vnoremap <unique> <PageUp> <cmd>call smoothie#do("\<C-U>") <CR>
      --   vnoremap <unique> <PageDown> <cmd>call smoothie#do("\<C-D>") <CR>
      -- ]])
    end
  }

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
        highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE
        highlight SignifySignAdd ctermfg=Green cterm=NONE
        highlight SignifySignDelete ctermfg=DarkRed cterm=NONE
        highlight SignifySignChange ctermfg=Magenta cterm=NONE
      ]])
    end
  }

  -- cf <https://nic-west.com/posts/workman-layout/>
  use {
    'https://github.com/nicwest/vim-workman',
    config = function()
      vim.cmd([[
        let g:workman_normal_workman = 0
        let g:workman_insert_workman = 0
        let g:workman_normal_qwerty = 0
        let g:workman_insert_qwerty = 0
      ]])
    end
  }

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
        highlight htmlH1 cterm=bold ctermfg=DarkMagenta
        highlight pandocAtxHeader cterm=bold ctermfg=DarkMagenta
        highlight pandocSetexHeader cterm=bold ctermfg=DarkMagenta
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
