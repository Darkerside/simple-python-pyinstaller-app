#!/usr/bin/env sh

set +x
python -m flask --app api run &
sleep 1
echo $! > .pidfile