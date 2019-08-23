#!/bin/bash

var1=~/runDBDocker.sh
echo -e "#!/bin/bash \nsudo fuser -k 5432/tcp \nsudo docker start postgres96\n" > $var1
sudo chmod 777 $var1

