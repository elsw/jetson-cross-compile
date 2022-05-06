#!/bin/bash
docker create -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static --name jet_container jet_image
docker cp src/ jet_container:/catkin_ws/
if [ -d "jet_devel" ] 
then
	echo "Copying already present devel folder"
	docker cp jet_devel/. jet_container:/catkin_ws/devel
fi
if [ -d "jet_build" ] 
then
	echo "Copying already present build folder"
	docker cp jet_build/. jet_container:/catkin_ws/build
fi
if [ -d "jet_install" ] 
then
	echo "Copying already present install folder"
	docker cp jet_install/. jet_container:/catkin_ws/install
fi
docker start -a -i jet_container
docker cp jet_container:/catkin_ws/devel/. jet_devel
docker cp jet_container:/catkin_ws/build/. jet_build
docker cp jet_container:/catkin_ws/install/. jet_install
docker rm jet_container
