#!/usr/bin/env sh

echo ""
echo "run local server on port 5000"
pip3 install Flask
python -m flask --app app run -h 0.0.0.0 -p 5000 &
sleep 1
echo $! > .pidfile