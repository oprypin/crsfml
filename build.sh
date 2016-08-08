#!/bin/bash

set -o errexit

PATH="node_modules/.bin${PATH:+:$PATH}"

if ! command -v gitbook; then
    npm install gitbook-cli
fi

gitbook install .
gitbook build .
