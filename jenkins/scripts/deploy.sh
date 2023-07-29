# echo ""
# echo "remove the old build first"
# ssh -o StrictHostKeyChecking=no -l ec2-user 13.229.219.204 'cd dicoding/simple-python-pyinstaller-app; rm -r -f dist build'
# echo ""
# echo "pull the latest commit"
# ssh -o StrictHostKeyChecking=no -l ec2-user 13.229.219.204 'cd dicoding/simple-python-pyinstaller-app; git pull'

# echo ""
# echo "build the exec file"
# ssh -o StrictHostKeyChecking=no -l ec2-user 13.229.219.204 'cd dicoding/simple-python-pyinstaller-app; pyinstaller -F add2vals.py'

python -m flask --app api run -h 0.0.0.0 -p 5000 & 
echo $! > .pidfile

