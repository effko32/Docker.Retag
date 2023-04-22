#!/bin/sh

docker login -u $(registry_login) -p $(registry_password) $(registry_url)
docker login -u $(registry_login_target) -p $(registry_password_target) $(registry_url_target)

for i in $(docker search --format "{{.Name}}" $(registry_url)/$(registry_dir) --limit 100 | grep -E '(latest|$(Build.BuildId))')
do
  tag=$(echo $i)
  new_tag=$(echo $i | sed s/"$(registry_url)"//)
  echo $tag
  new_repo=$(registry_url_target)
  target_repo=${new_repo}$new_tag
  echo $target_repo
  docker pull $tag
  docker tag $tag $target_repo
  docker push $target_repo
  docker rmi $tag
  docker rmi $target_repo
done