#!/bin/bash

set -o errexit

rev="$(git rev-parse --short HEAD)"

git clone "$1" -b gh-pages gh-pages/

cd gh-pages

rm -rf tutorials
mv ../gitbook/_book tutorials

git config user.name 'Robot'
git config user.email '<>'

git add -A tutorials

for f in tutorials/*.html; do
    # See if there are any changes not related to "generator" or "revision"
    (git diff --staged "$f" | tail -n +5 | grep -E '^[+\-]' |
    grep -vE '<meta name="generator"|data-revision="') || unchanged+=("$f")
done
# Unstage files that changed only generation date
[ -n "$unchanged" ] && git reset -- "${unchanged[@]}"

git commit -m "Generate tutorials ($rev)"
git push origin gh-pages >/dev/null 2>&1
