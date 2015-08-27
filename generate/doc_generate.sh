#!/bin/bash

# Change to script's folder
cd $(dirname $0)

# Copy 'src' folder here
cp -r ../src .

# Remove everything related to CSFML module
rm -r src/*_lib.cr

# Remove everything that was previously in 'doc' folder
rm -r doc/*

# Transform every source file to get better docs
find src/ -type f -exec python3 doc_transform.py {} \;

# Use $1 (default `crystal`) to generate docs
${1:-crystal} doc

# Remove the copy 'src' folder
rm -r src

# Find the current tag or commit name
TAG=$(git describe --tags --exact-match || git rev-parse HEAD)

# Generate readme manually, because Crystal's implementation can't handle it
markdown ../README.md > doc/main.html

sed -i -r -e 's,<h1.+/h1>,<a href="https://github.com/BlaXpirit/crsfml"><img src="https://raw.githubusercontent.com/BlaXpirit/crsfml/master/logo.png" alt="CrSFML"/></a>,g' doc/main.html

# Replace local links with links to crsfml in main.html
sed -i -r -e 's,(href=")([^h][^t]),\1'"https://github.com/BlaXpirit/crsfml/tree/master/"'\2,g' doc/main.html
# Add "open in new page" directive in main.html
sed -i -r -e 's,(href="),target="_blank" \1,g' doc/main.html

# Replace commit name with tag name in links
find doc/ -type f -exec sed -i -r -e "s,blob/$(git rev-parse HEAD),blob/$TAG,g" {} \;
