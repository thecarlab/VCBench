#!/bin/bash
###
 # @Description: 
 # @Author: Sauron
 # @Date: 2023-11-15 18:02:39
 # @LastEditTime: 2023-11-17 22:54:51
 # @LastEditors: Sauron
### 

if [ -z $VCBENCH_HOME ] ; then
    VCBENCH_HOME=$(pwd)
    echo "WARNING: \$VCBENCH_HOME is not set; Setting it to ${VCBENCH_HOME}"
else
    echo "INFO: \$VCBENCH_HOME is set to ${VCBENCH_HOME}"
fi

if [ ! -d "$VCBENCH_HOME/dependencies" ]; then
	    mkdir dependencies
fi

sudo apt-get -y update
sudo apt-get install -y git wget cmake python3-pip unzip clang libpng-dev libgeos-dev
# Install opencv separately because pip3 install doesn't install all libraries
# opencv requires.
sudo apt-get install -y python3-opencv
python3 -m pip install user gdown
# Install Pygame if available.
PYGAME_PKG=`apt-cache search python3-pygame`
if [ -n "$PYGAME_PKG" ] ; then
    sudo apt-get install python3-pygame
fi

handle_choice() {
    package=$1
    read -p "Install $package? (y/n): " answer
    if [[ $answer =~ ^[Yy]$ ]]; then
        echo "Handling $package..."
        case $package in
            pylot)
                echo "Installing $package..."
		$VCBENCH_HOME/scripts/install_pylot.sh
                ;;
            carla)
                echo "Installing $package..."
		$VCBENCH_HOME/scripts/install_carla.sh
                ;;
            other_package)
                echo "Doing something with $package..."
                ;;
        esac
    else
        echo "Handling of $package skipped."
    fi
}

#handle_choice pylot
handle_choice carla