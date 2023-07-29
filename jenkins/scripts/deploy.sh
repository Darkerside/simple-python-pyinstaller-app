#!/usr/bin/env sh

set +x
python -m flask --app api run -p 3000 &
sleep 1
echo $! > .pidfile