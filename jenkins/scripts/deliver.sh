#!/usr/bin/env sh
pyinstaller -F add2vals.py

flask --app api run &
sleep 1
echo $! > .pidfile