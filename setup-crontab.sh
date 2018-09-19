#!/bin/bash

CRON_SCHEDULE="${CRON_SCHEDULE:=* * * * *}"
echo "Using cron schedule experession: ${CRON_SCHEDULE}"

echo -e "${CRON_SCHEDULE} root bash /run-diffengine.sh\n" > /etc/cron.d/diffengine-cron
chmod 0644 /etc/cron.d/diffengine-cron
