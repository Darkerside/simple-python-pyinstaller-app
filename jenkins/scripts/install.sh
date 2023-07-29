#!/usr/bin/env sh
set -x
python -m py_compile sources/add2vals.py sources/calc.py
set +x

ls > .defpath
cat .defpath

set -x
whoami
ls -la /home/venv/bin/pip
su root
pip3 install --upgrade pip && pip install wheel
pip3 install Flask --user
set +x