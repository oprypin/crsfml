#!/bin/bash
cd $(dirname $0)

python3 headers.py
python3 replacements.py headers_gen.h
python3 generate.py
cd ..
cp -r generate/*.cr src/

cd src
for f in ../patches/*.patch; do
    patch < $f
done
cd ..