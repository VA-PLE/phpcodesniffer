#!/bin/sh

GREEN='\033[0;33m'
NORMAL='\033[0m'
IMAGENAME=vaple/phpcodesniffer

echo "${GREEN}Remove all unused docker objects${NORMAL}"
echo "\n\nAre you sure? (y/n)"

read item1
case $item1 in
  y|Y )
    docker system prune -af;
    docker volume rm $(docker volume ls -f dangling=true -q);;
  n|N );;
esac

echo "${GREEN}Build images ${IMAGENAME}:`date +%y.%m`${NORMAL}"
echo "\n\nAre you sure? (y/n)"

read item2
case $item2 in
  y|Y )
    docker build -t ${IMAGENAME}:`date +%y.%m` . || exit;;
  n|N )
    exit;;
esac

echo "${GREEN}Push images to DockerHab${NORMAL}"
echo "\n\nAre you sure? (y/n)"

read item3
case $item3 in
  y|Y )
    docker push ${IMAGENAME}:`date +%y.%m`;;
  n|N )
    exit;;
esac
