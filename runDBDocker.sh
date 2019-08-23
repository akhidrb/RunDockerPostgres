#!/bin/bash 
#sudo fuser -k 5432/tcp 
#sudo docker start postgres96

if [[ $(docker images -q postgres:9.6) ]]; then 
	echo "postgres:9.6 image exists"
else
	echo "postgres:9.6 image does not exist"
	sudo docker pull postgres:9.6	
fi

if [ ! "$(docker ps -a | grep 'postgres96')" ]; then 
	echo "container doesn't exist"
	if [ "$(sudo fuser 5432/tcp)" ]; then
                echo "other services are running on port"
                sudo fuser -k 5432/tcp && sudo docker run --name postgres96 -p 5432:5432 --tmpfs /var/lib/postgresql/data:rw -e POSTGRES_PASSWORD=postgres -d postgres:9.6
        else
                sudo docker run --name postgres96 -p 5432:5432 --tmpfs /var/lib/postgresql/data:rw -e POSTGRES_PASSWORD=postgres -d postgres:9.6
        fi
else
	echo "container exists"
fi

if [ "$(docker ps -q -f name=postgres96)" ]; then
	# run your container
    	echo "container is up"
else
	echo "container is down"
	if [ "$(sudo fuser 5432/tcp)" ]; then
		echo "other services are running on port"
		sudo fuser -k 5432/tcp && sudo docker start postgres96
	else
		sudo docker start postgres96
	fi
fi
