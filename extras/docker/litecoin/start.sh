#!/bin/bash

# Launch, utilizing the SIGTERM/SIGINT propagation pattern from
# http://veithen.github.io/2014/11/16/sigterm-propagation.html
: ${PARAMS:=""}
trap 'kill -TERM $PID' TERM INT
su litecoin -c "/usr/local/bin/litecoind --datadir=/home/litecoin/.litecoin ${PARAMS} $@" &
PID=$!
wait $PID
trap - TERM INT
wait $PID
EXIT_STATUS=$?
