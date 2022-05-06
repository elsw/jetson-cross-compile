#!/bin/bash
docker create -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static --name raspi_container raspi_image
docker cp src/ raspi_container:/catkin_ws/
if [ -d "raspi_devel" ] 
then
	echo "Copying already present devel folder"
	docker cp raspi_devel/. raspi_container:/catkin_ws/
fi
if [ -d "raspi_build" ] 
then
	echo "Copying already present build folder"
	docker cp raspi_build/. raspi_container:/catkin_ws/
fi
if [ -d "raspi_install" ] 
then
	echo "Copying already present install folder"
	docker cp raspi_install/. raspi_container:/catkin_ws/
fi
docker start -a -i raspi_container
docker cp raspi_container:/catkin_ws/devel/. raspi_devel
docker cp raspi_container:/catkin_ws/build/. raspi_build
docker cp raspi_container:/catkin_ws/install/. raspi_install
docker rm raspi_container
