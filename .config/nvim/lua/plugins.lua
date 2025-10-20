-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("lazy").setup({
  spec = {
    { "https://github.com/neovim/nvim-lspconfig" },

    { "https://github.com/ellisonleao/gruvbox.nvim",
      priority = 1000 ,
      config = true,
      init = function()
        require("gruvbox").setup({
          terminal_colors = true, -- add neovim terminal colors
          undercurl = true,
          underline = true,
          bold = true,
          italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
          },
          strikethrough = true,
          invert_selection = false,
          invert_signs = false,
          invert_tabline = false,
          invert_intend_guides = false,
          inverse = true, -- invert background for search, diffs, statuslines and errors
          contrast = "hard",
          palette_overrides = {},
          overrides = {
            SignColumn = { bg = "NONE" },
            DiffAdd = { fg = "green", bg = "NONE" },
            DiffChange = { fg = "gray", bg = "NONE" },
            DiffDelete = { fg = "darkred", bg = "NONE" },
            markdownH1 = { underline = true, bold = true },
            markdownH2 = { underline = true, bold = true, italic = true },
            markdownH3 = { underline = true, italic = true },
            markdownItalic = { italic = true },
            markdownItalicDelimiter = { italic = true, fg="gray" },
            markdownBold = { bold = true },
            markdownBoldDelimiter = { bold = true, fg = "gray" },
            markdownCode = { fg = "black", bg = "gray" },
            markdownAutomaticLink = { underline = true },
            yamlBlockMappingKey = { bold = true, fg = "black" },
            yamlDocumentStart = { fg = "gray" },
          },
          dim_inactive = false,
          transparent_mode = true,
        })
        vim.cmd("colorscheme gruvbox")
      end
    },

    -- Integrate direnv; see <https://direnv.net/>
    { 'https://github.com/direnv/direnv.vim' },

    -- Visually indicate marks
    { 'https://github.com/kshenoy/vim-signature' },

    -- Automatically detect indentation
    { 'https://github.com/tpope/vim-sleuth' },

    -- More sensible word motions
    { 'https://github.com/chaoren/vim-wordmotion' },

    -- Auto comment lines
    { "https://github.com/tpope/vim-commentary",
      init = function()
        vim.cmd[[
        autocmd FileType turtle setlocal commentstring=#\ %s
        ]]
      end
    },

    -- Set working directory to project root
    { 'https://github.com/airblade/vim-rooter.git',
      init = function()
        vim.cmd([[
          let g:rooter_silent_chdir = 1
          let g:rooter_change_directory_for_non_project_files = 'current'
          let g:rooter_resolve_links = 1
          let g:rooter_patterns = ['.git', 'Makefile']
          let g:rooter_buftypes = ['']
        ]])
      end
    },

    -- Return to last position when editing files
    { 'https://github.com/farmergreg/vim-lastplace' },

    -- Git signs, works for both git and svn
    { 'https://github.com/mhinz/vim-signify.git',
      init = function()
        vim.cmd([[
          set signcolumn=auto
          let g:signify_sign_add = '✚'
          let g:signify_sign_delete = '✖'
          let g:signify_sign_delete_first_line = '●'
          let g:signify_sign_change = '✱'
        ]])
      end
    },

    -- Lua

    { 'https://github.com/smoka7/hop.nvim',
      version = "*",
      opts = {
        keys = 'etovxqpdygfblzhckisuran'
      }
    },

    -- Comfortable middle ground between hop and sneak
    { 'https://github.com/ggandor/leap.nvim',
      init = function()
        require('leap').add_default_mappings()
        require('leap').opts.highlight_unlabeled_phase_one_targets = true

        -- So that the first match in leap.nvim is shown, see 
        -- https://github.com/ggandor/leap.nvim/issues/27
        vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })
        vim.api.nvim_set_hl(0, 'LeapMatch', { fg = 'white', bg = 'black' })
        vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'white', bg = 'blue' })
        vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = 'white', bg = 'red' })
      end
    },

    { 'https://github.com/ggandor/flit.nvim',
      init = function()
        require('flit').setup()
      end
    },

    -- Block matching via %
    { 'https://github.com/andymass/vim-matchup',
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end
    },

    -- Syntax highlighting
    { 'https://github.com/niklasl/vim-rdf' },
    { 'https://github.com/ledger/vim-ledger' },

    { 'https://github.com/stevearc/oil.nvim',
      init = function()
        local oil = require("oil")
        oil.setup({
          default_file_explorer = false,
          columns = {
            "icon", -- "permissions", "size", "mtime",
          },
          buf_options = {
            buflisted = true,
            bufhidden = "hide",
          },
          win_options = {
            wrap = false,
            signcolumn = "no",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "n",
          },
          restore_win_options = true,
          skip_confirm_for_simple_edits = false,
          delete_to_trash = false,
          trash_command = "trash-put",
          prompt_save_on_select_new_entry = true,
          -- See :help oil-actions for a list of all available actions
          keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["q"] = { callback = oil.parent, desc = "", nowait = true },
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["g."] = "actions.toggle_hidden",
          },
          use_default_keymaps = true,
          view_options = {
            show_hidden = false,
            is_hidden_file = function(name, bufnr)
              return vim.startswith(name, ".")
            end,
            is_always_hidden = function(name, bufnr)
              return false
            end,
          },
        })
        -- vim.keymap.set('n', 'q', "<CMD>Oil<CR>", {})
      end
    },

    {
      "https://github.com/nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      lazy = false, -- neo-tree will lazily load itself
      ---@module "neo-tree"
      ---@type neotree.Config?
      opts = {
        -- fill any relevant options here
      },
      init = function()
        vim.keymap.set('n', 't', ':Neotree source=filesystem reveal=true position=left toggle<CR>')
        require("neo-tree").setup({
          source_selector = {
            winbar = true,
          }
        })

      end
    },


    { 'https://github.com/folke/zen-mode.nvim',
      init = function()
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
          -- on_open = function(_)
          --   vim.cmd 'cabbrev <buffer> q let b:quitting = 1 <bar> q'
          --   vim.cmd 'cabbrev <buffer> wq let b:quitting = 1 <bar> wq'
          -- end,
          -- on_close = function()
          --   if vim.b.quitting == 1 then
          --     vim.b.quitting = 0
          --     vim.cmd 'q'
          --   end
          -- end,
        }

        -- vim.cmd([[
        --   autocmd VimEnter * nested if winwidth("%") >= 100 | execute 'ZenMode' | endif
        -- ]])
      end
    },

    -- Git merge/diff viewer
    { 'https://github.com/sindrets/diffview.nvim' },

    -- 

  },
  install = { },
  checker = { enabled = false },
})
