#!/bin/bash
# pubs - Command-line bibliography manager
# See https://github.com/pubs/pubs
#
# It's very convenient to manage references and associated documents on the
# command line, and so far `pubs` seems to be the most simple solution.

# I'm also considering using [papis](https://github.com/papis/papis). `papis`
# seems to be better at automatic downloading, but I find the interface less
# intuitive (more idiosyncratic), so I'm using `pubs` for now. Perhaps also see
# [paperboy](https://github.com/2mol/pboy)
set -euo pipefail

sudo apt install python3-pip 
pip3 install pubs

# Also activate autocompletion
sudo apt install python3-argcomplete
sudo activate-global-python-argcomplete3

# I'm not entirely sure why, but the completion isn't picked up automatically.
# For now I'll do it manually but I really need to clean up my shell
# source /etc/bash_completion
# eval "$(register-python-argcomplete3 pubs)"
