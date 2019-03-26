#!/bin/bash
echo "Image will contains: vscode, git, g++-8, grppi, rplsh\n"
echo
read -p "--> Install? [y] to continue " -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then  
    echo "Building DockerFile.\n
        Image Name: thedeveloper.\n
        It could take few minutes"
    sudo docker build -t thedeveloper . 
    echo "Create Persistent Storage in /home/developer"
    sudo docker volume create --name persistent
    echo "Running.."
    sudo docker run --rm --net=host --ipc=host -e DISPLAY=$DISPLAY --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v peristent:/home/developer -it thedeveloper
    echo "Password root: pippo"
    echo "Password developer: pippo"
fi

