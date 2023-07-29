#!/usr/bin/env sh

python -m py_compile sources/add2vals.py sources/calc.py

ls > .defpath
cat .defpath

whoami
ls -la /home/venv/bin/pip
su root
pip3 install --upgrade pip && pip install wheel
pip3 install Flask --user