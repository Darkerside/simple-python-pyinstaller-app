#!/usr/bin/env sh

set +x
python -m PyInstaller -F add2vals.py
ls

python -m flask --app api run -p 3000 &
sleep 1
echo $! > .pidfile