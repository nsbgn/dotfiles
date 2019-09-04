#!/bin/bash
# Vim plugins

mkdir -p ~/.vim/autoload ~/.vim/bundle && cd ~/.vim/bundle
git clone https://github.com/airblade/vim-rooter.git # Sets cwd to project root
git clone https://github.com/jamessan/vim-gnupg.git # Open encrypted files
git clone https://github.com/vim-syntastic/syntastic.git # Check code syntax
git clone https://github.com/bitc/vim-hdevtools.git # Interactive Haskell development
git clone https://github.com/vim-pandoc/vim-pandoc-syntax.git # Highlight markdown
git clone https://github.com/vito-c/jq.vim # Highlight jq files
git clone https://github.com/ledger/vim-ledger.git # ledger/hledger journal writing
git clone https://github.com/mhinz/vim-signify # Show git or svn changes
git clone https://github.com/tpope/vim-fugitive.git # Git wrapper to see blame etc
git clone git://repo.or.cz/vcscommand.git # VCS wrapper to see blame
