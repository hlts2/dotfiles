# !/bin/zsh

WHOAMI=`whoami`

sudo chown -R $WHOAMI:$WHOAMI /usr/lib/node_modules
sudo chown -R $WHOAMI:$WHOAMI /usr/bin/npm



sudo gpasswd -a $USER vboxusers
sudo sh -c "echo modprobe vboxdrv > /etc/modules-load.d/vbox.conf"
