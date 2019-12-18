#!/bin/bash
# This installs support for some languages via the Language Server Protocol
set -euo pipefail
IFS=$'\n\t'

# The  LSP server protocol is supported in vim through plugins like:
# - https://github.com/prabirshrestha/vim-lsp.git
# - https://github.com/neoclide/coc.nvim
# - https://github.com/autozimu/LanguageClient-neovim


##############################################################################
# Rust
# See https://github.com/rust-lang/rls
# Assume rustup is installed

rustup update
rustup component add rls rust-analysis rust-src

##############################################################################
# Python
# See https://github.com/palantir/python-language-server
# Assume pip is installed

pip3 install 'python-language-server[rope,pyflakes,pycodestyle]' pyls-mypy

##############################################################################
# Haskell
# See https://github.com/haskell/haskell-ide-engine
# Assume stack is installed

sudo apt install libicu-dev libtinfo-dev libgmp-dev

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/haskell-ide-engine"
git clone http://github.com/haskell/haskell-ide-engine "$INSTALL" --recurse-submodules
cd "$INSTALL"

stack upgrade

# Install appropriate cabal version
stack ./install.hs stack-install-cabal

# Install hie LTS
stack ./install.hs hie-8.4.4
stack ./install.hs build-data

# Generate fallback hoogle database
stack --stack-yaml=$INSTALL/stack-8.4.4.yml exec hoogle generate
