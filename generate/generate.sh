#!/bin/bash
cd $(dirname $0)

python3 headers.py
python3 generate.py
cd ..
cp -r generate/*.cr src/
rm generate/*.cr
