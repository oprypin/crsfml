#!/bin/bash

# Usage: ./deploy.sh origin

set -e

cd "$(dirname "$0")"

dest_branch='gh-pages'
dest_repo="$(pwd)/.$dest_branch"
dest_dir="$dest_repo/tutorials"

set -x

test -d "$dest_repo" || git worktree add "$dest_repo" "$dest_branch"

rev="$(git rev-parse HEAD)"

mkdocs build -d "$dest_dir"
rm "$dest_dir"/sitemap.*

pushd "$dest_repo"
git add -A "$dest_dir"
git diff --staged --quiet && exit
git -c user.name='Robot' -c user.email='<>' commit -m "Generate tutorials ($rev)"
for remote in "$@"; do
    git push "$remote" "$dest_branch"
done
popd
