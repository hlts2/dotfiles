# !/bin/zsh

WHOAMI=`whoami`

echo $WHOAMI

sudo chown -R $WHOAMI:$WHOAMI /usr/bin
sudo chown -R $WHOAMI:$WHOAMI /usr/lib/node_modules

sudo chown -R $WHOAMI:$WHOAMI $HOME
sudo chmod 755 $HOME
