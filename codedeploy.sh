#!/bin/bash -x

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`

REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"

sudo apt-get update -y
sudo apt-get install ruby wget -y
sudo apt-get install httpd

echo "Type your user name, followed by [ENTER]:"
read user_name

cd /home/$user_name

wget https://aws-codedeploy-$REGION.s3.amazonaws.com/latest/install
chmod +x ./install

./install auto

