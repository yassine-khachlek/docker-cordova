#!/bin/bash

if [ -z "$1" ]
  then
    echo "The application name is missing"
    exit 1
fi

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PROJECTS_FOLDER="projects"

mkdir -p $SCRIPT_PATH/$PROJECTS_FOLDER

APP_NAME=$1

docker build --rm -t cordova_builder .

docker run -v $SCRIPT_PATH/$PROJECTS_FOLDER/$APP_NAME:/var/cordova cordova_builder cordova --verbose build android
