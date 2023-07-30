#!/usr/bin/env sh

echo ""
echo "run local server on port 5000"
pip3 install Flask
python -m flask --app app run &
sleep 1
echo $! > .pidfile