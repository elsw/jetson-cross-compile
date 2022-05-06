#!/bin/bash

#Run deps should be being run by the DockerFile when building a new image
#Will look through dependancies.txt and install everything
#Pass the ROS distro as an argument
DISTRO=$1

COMMAND="apt-get install -y --no-install-recommends "

while IFS= read -r line
do
  #Get dependancy, replace the _ with - and append to command
  DEP="ros-${DISTRO}-$line"
  DEP_FIXED=${DEP//_/-}
  
  COMMAND="$COMMAND $DEP_FIXED"
done < "dependancies.txt"

echo "final command is ${COMMAND}"

eval "${COMMAND}"
