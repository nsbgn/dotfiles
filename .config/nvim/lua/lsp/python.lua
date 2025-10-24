-- Note that mypy won't work on editable installs. See:
-- https://github.com/microsoft/pylance-release/blob/main/TROUBLESHOOTING.md#editable-install-modules-not-found
-- https://setuptools.pypa.io/en/latest/userguide/development_mode.html#strict-editable-installs
--
-- https://github.com/python-lsp/python-lsp-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- $ pip3 install python-lsp-server[all] pylsp-mypy mypy
vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      -- configurationSources = {"flake8"},
      plugins = {
        jedi_completion = {enabled = true},
        jedi_hover = {enabled = true},
        jedi_references = {enabled = true},
        jedi_signature_help = {enabled = true},
        jedi_symbols = {enabled = true, all_scopes = true},
        pycodestyle = {
          enabled = true,
          ignore = {'E128', 'W503', 'E211', 'W291'}
        },
        flake8 = {
          enabled = false,
          ignore = {'E128', 'W503', 'E211'},
          maxLineLength = 79
        },
        mypy = {enabled = true},
        pylsp_mypy = {enabled = true},
        isort = {enabled = false},
        yapf = {enabled = true},
        pylint = {enabled = false},
        pydocstyle = {enabled = false},
        mccabe = {enabled = false},
        preload = {enabled = true},
        rope_completion = {enabled = true}
      }
    }
  }
})
