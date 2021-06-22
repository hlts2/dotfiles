# !/bin/zsh

WHOAMI=`whoami`

sudo chown -R $WHOAMI:$WHOAMI /usr/lib/node_modules
sudo chown -R $WHOAMI:$WHOAMI /usr/bin/npm
