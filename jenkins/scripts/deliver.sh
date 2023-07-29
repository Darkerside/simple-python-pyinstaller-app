#!/usr/bin/env sh

set +x
if [ ! -d "/var/jenkins_home/pythonapp" ] 
then
  mkdir ~/pythonapp
fi
cp ./api.py ~/pythonapp/api.py
cp ./add2vals ~/pythonapp/add2vals