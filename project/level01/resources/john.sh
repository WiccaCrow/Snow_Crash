#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo snap install john-the-ripper > /dev/null
    john ./lvl01ForJohn              2> /dev/null
    echo
    john ./lvl01ForJohn --show       2> /dev/null    \
        | grep flag01               \
        | grep -Eo ':[^(:)]*:'      \
        | head -1                   \
        | grep -E -o '[^(':')](.*)[^(':')]'
    # ||
    # \/
    # abcdefg
    sudo snap remove john-the-ripper > /dev/null
elif [[ "$OSTYPE" == "darwin"* ]]; then
    curl -O https://download.openwall.net/pub/projects/john/contrib/macosx/john-1.8.0.9-jumbo-macosx_avx2.zip
    chmod 777 ./john-1.8.0.9-jumbo-macosx_avx2.zip
    unzip john-1.8.0.9-jumbo-macosx_avx2.zip
    rm -rf ./john-1.8.0.9-jumbo-macosx_avx2.zip
    cd  ./john-1.8.0.9-jumbo-macosx_avx2/run

    ./john                                          \
        ../../lvl01ForJohn                          \
        # --format=descrypt-opencl                \
        # --wordlist=/usr/share/john/password.lst \
        # --show                                  \
    echo
    cat ./john.pot  2> /dev/null    \
        | grep -Eo ':.*'            \
        | grep -E -o '[^(':')](.*)'
    # ||
    # \/
    # abcdefg
    echo
    cd  ../../
    rm -rf john-1.8.0.9-jumbo-macosx_avx2
else
    echo Oopps
    exit
fi
