#!/usr/bin/env sh
curl http://127.0.0.1:5000
sleep 1m
set -x
kill $(cat .pidfile)