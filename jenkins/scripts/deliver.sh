#!/usr/bin/env sh

set +x
python -m PyInstaller -F add2vals.py

python -m flask --app api run &
sleep 1
echo $! > .pidfile