#!/bin/bash

set -e
cd "$(dirname "$0")"

mkdocs build
pygmentize -f html -S default -a '.codehilite' >site/codehilite.css
rm site/sitemap.*
