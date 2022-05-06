#!/bin/bash

rosdep install --from-paths src --ignore-src -r -y
catkin_make -j4 install
