#!/bin/bash

chmod 777 .

echo "import sys" > myscript.py
echo "" >> myscript.py
echo "f = open('token','r')" >> myscript.py
echo "tokenstr=f.read()" >> myscript.py
echo "for i in range(len(tokenstr) - 1):" >> myscript.py
echo "    sys.stdout.write(chr(ord(tokenstr[i])-i))" >> myscript.py
echo "print" >> myscript.py

python myscript.py
# ||
# \/
# f3iji1ju5yuevaus41q1afiuq

su flag09
# Password: f3iji1ju5yuevaus41q1afiuq

# getflag
