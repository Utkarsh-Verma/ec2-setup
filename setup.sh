#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y
apps=(

git
nginx
nodejs
npm
zsh
mysql-server
python-pip

)

for app in "${apps[@]}"
do
	sudo apt-get install -y $app
done

npm install pm2 -g
pip install --upgrade pip
pip install --upgrade virtualenv
virtualenv -p /usr/bin/python27 venv
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s `which zsh`
