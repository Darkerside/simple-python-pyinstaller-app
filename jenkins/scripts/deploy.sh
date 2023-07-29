#!/usr/bin/env sh
set +x
pip3 install Flask
python -m flask --app api run -p 3000 &
sleep 1
echo $! > .pidfile