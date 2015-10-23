#!/bin/bash

set -o errexit

npm install gitbook-cli

PATH="node_modules/.bin${PATH:+:$PATH}"

gitbook install gitbook
gitbook build gitbook
