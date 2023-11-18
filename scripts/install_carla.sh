#!/bin/bash
###
 # @Description: 
 # @Author: Sauron
 # @Date: 2023-11-15 20:42:30
 # @LastEditTime: 2023-11-17 21:46:12
 # @LastEditors: Sauron
### 

###### Download the Carla simulator ######
echo "[x] Downloading the CARLA 0.9.10.1 simulator..."
cd $VCBENCH_HOME/dependencies/
if [ ! -d "CARLA_0.9.10.1" ]; then
    mkdir CARLA_0.9.10.1
    cd CARLA_0.9.10.1
    wget https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.10.1.tar.gz
    tar -xvf CARLA_0.9.10.1.tar.gz
    rm CARLA_0.9.10.1.tar.gz
fi