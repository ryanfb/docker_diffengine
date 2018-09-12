#!/bin/bash

export LC_ALL='en_US.UTF-8'
export PATH="/usr/local/bin:${PATH}"
DIFFENGINE_TIMEOUT="${DIFFENGINE_TIMEOUT:=1h}"

( flock -xn /tmp/diffengine.lock timeout $DIFFENGINE_TIMEOUT /usr/local/bin/diffengine /diffengine >> /tmp/diffengine.log 2>&1 ; rm -r /diffengine/diffs && mkdir /diffengine/diffs ) &
