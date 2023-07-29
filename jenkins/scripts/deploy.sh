#!/usr/bin/env sh
# creating deployment on server

mkdir ~/pythonapp
cp add2vals ~/pythonapp/add2vals
cp app.py ~/app.py

rsync -auvvzr --rsh 'ssh -i "jenkinspair.pem"' ~/pythonapp/ ec2-user@ec2-13-229-219-204.ap-southeast-1.compute.amazonaws.com:~/pythonapp/