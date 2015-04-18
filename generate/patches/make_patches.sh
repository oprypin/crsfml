#!/bin/bash
cd $(dirname $0)

cd ..
for f in *.cr; do
    cd ..
    diff -u generate/$f src/csfml/$f > generate/patches/$f.patch
    if [ ! -s generate/patches/$f.patch ] ; then
        rm generate/patches/$f.patch
    fi
    cd generate
done
