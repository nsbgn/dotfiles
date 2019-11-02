#!/bin/bash
# Command-line bibliography manager
# See https://github.com/pubs/pubs
#
# It's very convenient to manage references and associated documents on the
# command line, and so far `pubs` seems to be the most simple solution.

# I'm also considering using [papis](https://github.com/papis/papis). `papis`
# seems to be better at automatic downloading, but I find the interface less
# intuitive (more idiosyncratic), so I'm using `pubs` for now. Perhaps also see
# [paperboy](https://github.com/2mol/pboy)

sudo apt install python3-pip 
pip3 install pubs
