#!/bin/bash
# weasyprint - Print HTML to PDF. Alternative to wkhtmltopdf
set -euo pipefail
IFS=$'\n\t'

sudo apt install python3-pip 
pip3 install weasyprint

