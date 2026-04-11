docker-compose ps -a
docker-compose build

docker-compose up -d
docker-compose up -d --remove-orphans
docker-compose down -v
docker-compose down --rmi all

docker-compose start
docker-compose stop
