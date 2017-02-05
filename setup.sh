#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y
export LC_ALL=C
apps=(

git
nginx
zsh
mysql-server
python-pip

)

for app in "${apps[@]}"
do
	sudo apt-get install -y $app
done

sudo apt-get install build-essential libssl-dev
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh
bash install_nvm.sh
source ~/.nvm/nvm.sh
nvm install 6.9.5
npm install pm2 -g
pip install --upgrade pip
pip install --upgrade virtualenv
virtualenv -p /usr/bin/python venv
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s `which zsh`
