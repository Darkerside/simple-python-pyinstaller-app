#!/usr/bin/env sh

sleep 1m
echo "Pipeline Diakhiri!"
kill $(cat .pidfile)