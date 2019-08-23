#!/bin/bash

var1=runDBDocker.sh
sudo chmod 777 $var1
sudo cp $var1 /etc/init.d/
sudo update-rc.d $var1 defaults

