#!/bin/sh
for i in $(docker images --format "{{.Repository}}:{{.Tag}}");
do
  tag=$(echo $i)
  new_tag=latest
  new_repo=172.30.51.237:8083
  target_repo=${new_repo}/$tag
  echo $tag
  echo $target_repo
  docker tag $tag $target_repo
  docker push $target_repo
  docker rmi $target_repo
done 
