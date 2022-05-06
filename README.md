# JETSON-Cross-Compile

This repo holds code to cross compile for JETSON using Docker and qemu, tested on Ubuntu 20

## Install Dependancies

 - Install Docker
   	https://docs.docker.com/engine/install/ubuntu/
 - Install QEMU
	`sudo apt-get update && apt-get install -y --no-install-recommends qemu-user-static binfmt-support`
	`update-binfmts --enable qemu-arm`
	`update-binfmts --display qemu-arm`
	
## Create Dependancy List

Before we create the docker image, we create a dependancy list so that all the libraries wee want are pre-installed each time we want to build.

This is optional but makes the building process much much faster.

Navigate to a catkin workspace

`cd Documents/catkin_ws`

now run 

`rosdep keys --from-paths src`

copy the list and paste into 

`jetson_cross_compile/dependancies.txt`

and repeat for all workspaces you will be using the cross compiler for	

Remove any local dependancies
	
## Setup Docker images	
	
 - Setup Docker Image of JETSON
	`cd jetson_cross_compile
 	`./jetson_setup`
 - Setup commands
 	`cd ${HOME}`
 	`nano .bash_aliases`
 	`alias jetson_make='bash $HOME/cross-compile-arm-ros/jetson/jetson_make.sh'`
 	
 	
## Running catkin_make for JETSON

Navigate to your workspace and execute

`jetson_make`

## Setting up your packages to be installed

Before the install folder is correctly populated, you need to add the install macros to your CMakeLists.txt files

To install folders with static files (.launch,.yaml, etc...) use
```
foreach(dir launch config)
        install(DIRECTORY ${dir}/
                DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/${dir})
endforeach(dir)
```

To install librarys use
```
install(TARGETS ${PROJECT_NAME}
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION}
)
```

To install executables use
```
install(TARGETS ${PROJECT_NAME}_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
```
To install header files use
```
install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  PATTERN ".svn" EXCLUDE
)
```

## Running your Compiled code on the target

Copy the compiled install files to the target and operate the ROS as per usual (no need to copy the src)

```
source jet_install/setup.bash
roslaunch your_node your_launch.launch
```

## Compile times for sample large code base

Docker Emulated (Intel i7):

	Build Time : 6:00
	
JETSON Nano 2GB

	Build Time: 12:30
