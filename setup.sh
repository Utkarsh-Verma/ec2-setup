#!/bin/bash
apps=(

git
nginx
nodejs
npm
zsh
mysql-server

)

for app in "${apps[@]}"
do
	sudo apt-get install -y $app
done

sudo npm install pm2 -g
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s `which zsh`
