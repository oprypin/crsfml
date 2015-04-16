#!/bin/bash
cd $(dirname $0)

cd ../generate
for f in *.cr; do
    cd ..
    diff -u generate/$f src/csfml/$f > patches/$f.patch
    cd generate
done
