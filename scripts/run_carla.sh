#!/bin/bash

if [ -z "$1" ]; then
    PORT=2000
else
    PORT=$1
fi

if [ "$2" = "true" ]; then
    SDL_VIDEODRIVER=offscreen ${CARLA_HOME}/CarlaUE4.sh -opengl -windowed -ResX=800 -ResY=600 -carla-server -world-port=$PORT -benchmark -fps=20 -quality-level=Epic
else
    ${CARLA_HOME}/CarlaUE4.sh -opengl -windowed -ResX=800 -ResY=600 -carla-server -world-port=$PORT -benchmark -fps=20 -quality-level=Epic
fi