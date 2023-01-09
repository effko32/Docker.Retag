#!/bin/sh

for repo in $(cat ./images.txt); 
do 
  docker pull $repo; 
done
