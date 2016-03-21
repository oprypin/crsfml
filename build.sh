#!/bin/bash

set -o errexit
set -o verbose

export PATH="$PWD/node_modules/.bin:$PWD/pygments:${PATH:+:$PATH}"

if ! [ -d pygments ]; then
    curl https://bitbucket.org/BlaXpirit/pygments/get/crystal.tar.gz | tar xz
    mv *pygments* pygments
fi

if ! command -v gitbook; then
    npm install gitbook-cli
fi

gitbook install gitbook
gitbook build gitbook
