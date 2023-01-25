#!/bin/bash

echo "------------------------------------------------------------------"
read -p "Enter the name of network you want to use host or bridge:->" net
echo "------------------------------------------------------------------"

if [[ $net == bridge ]];
then
	echo "----------------------------------------------------------"
        read -p "Enter the name of  bridge network you want to run:->" br
	echo "----------------------------------------------------------"
        docker network create --driver bridge $br
	echo "-----------------------"
	echo " $br,network is created"
	echo "-----------------------"
fi

i=1
while [[ $i -lt 6 ]]
do
        if [[ $net == host ]];then
		echo "-------------------------------------"
                read -p "Enter the name of container:->" con
		echo "--------------------------------------"
                docker run -dt --name $con --network $net ubuntu
		echo "------------------------------------------"
		echo " $con, container is running on host network"
		echo "-------------------------------------------"
        else
		echo "----------------------------------------------------"
                read -p "Enter the name of container you want to run:->" co
		echo "----------------------------------------------------"
                docker run -dt --name $co --network $br ubuntu
		echo "--------------------------------------------------"
		echo " $co, container is running on $br, bridge netwok."
		echo "--------------------------------------------------"
        fi
        i=`expr $i + 1`
done
echo "----------------------------------------------------------"
read -p "Enter the name of container you want to go inside:->" c
echo "----------------------------------------------------------"
docker exec --user root $c apt-get -y update
echo "-------------------------------------------"
echo "************updation done******************"
echo "-------------------------------------------"
docker exec --user root $c apt-get -y install net-tools
echo "-------------------------------------------------"
echo "**********Installation of net-tools done*********"
echo "-------------------------------------------------"
docker exec --user root $c apt-get -y install iputils-ping
echo "---------------------------------------------------"
echo "********Installation of iputils-ping done**********"
echo "---------------------------------------------------"
read -p "Enter the name you want to ping:->" a
echo "---------------------------------------------------"
docker exec --user root $c ping $a -c 3
echo "---------------------------------------------------"
echo "-----------------DONE------------------------------"
echo "---------------------------------------------------"
