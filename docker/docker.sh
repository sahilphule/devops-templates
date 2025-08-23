docker images
docker rmi <image-name>
docker rmi -f $(docker images -aq)

docker stats
docker ps -a
docker run -d --name <container-name> -p <port>:<port> <image-name>
docker restart <container-name>
docker stop <container-name>
docker logs <container-name> --follow
docker rm <container-name>
docker rm -v <container-name>

docker build -t <image-name>:<image-tag> .
docker build --build-arg GITHUB_PAT=<pat-token> -t <image-name>:<image-tag> .
docker tag <image-name>:<image-tag> <username>/<new-image-name>:<new-image-tag>
docker login -u <username> -p <password>
docker push <username>/<new-image-name>:<new-image-tag>
docker pull <username>/<image-name>:<image-tag>

docker create volume <volume-name>
docker volume ls
docker volume rm <volume-name>
docker volume prune

docker exec -it <container-name> sh
docker exec -it <source-container-name> ping <destination-container-name>

docker network ls
docker network inspect <network-name>

sudo rm -r shared

docker context ls
docker context create ecs <context-name>
docker context create ecs-local context <context-name>
docker context use <context-name>

docker context create <context-name> --docker host=ssh://<user>@<public-ip>

docker system df
docker system prune -a
docker images -f dangling=true

Set-Service ssh-agent -StartupType <Automatic>
Start-Service ssh-agent
ssh-add -l
ssh-add <key.pem file path>
