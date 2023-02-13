#!/bin/bash

curl -O https://download.openwall.net/pub/projects/john/contrib/macosx/john-1.8.0.9-jumbo-macosx_avx2.zip
chmod 777 ./john-1.8.0.9-jumbo-macosx_avx2.zip
unzip john-1.8.0.9-jumbo-macosx_avx2.zip
rm -rf ./john-1.8.0.9-jumbo-macosx_avx2.zip
cd  ~/Desktop/Snow_Crash/Vbox/john-1.8.0.9-jumbo-macosx_avx2/run

./john                                          \
        ~/Desktop/Snow_Crash/lvl01ForJohn       \
        # --format=descrypt-opencl                \
        # --wordlist=/usr/share/john/password.lst \
        # --show                                  \
echo
cat ~/Desktop/Snow_Crash/Vbox/john-1.8.0.9-jumbo-macosx_avx2/run/john.pot

echo
cd  ~/Desktop/Snow_Crash/Vbox
rm -rf john-1.8.0.9-jumbo-macosx_avx2