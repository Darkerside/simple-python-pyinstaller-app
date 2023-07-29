echo ""
echo "remove the old build first"
ssh -o StrictHostKeyChecking=no -l ec2-user 13.229.219.204 'sudo su; cd dicoding/simple-python-pyinstaller-app; rm -r -f dist build'

echo ""
echo "pull the latest commit"
ssh -o StrictHostKeyChecking=no -l ec2-user 13.229.219.204 'sudo su; cd dicoding/simple-python-pyinstaller-app; git pull'

echo ""
echo "build the exec file"
ssh -o StrictHostKeyChecking=no -l ec2-user 13.229.219.204 'sudo su; cd dicoding/simple-python-pyinstaller-app; pyinstaller -F ./sources/add2vals.py'
