Green='\033[0;32m'
lightGray='\033[1;30m'
NC='\033[0m' # No Color
echo "${NC}👉 ${Green} init Docker compose ${lightGray}"

echo "  ${NC}👉 ${Green} create director Mongo${lightGray}"

mkdir -p ../mongodb/database
chmod -R 777 ../mongodb

echo "  ${NC}👉 ${Green} create director rabbitmq${lightGray}"

mkdir -p ../rabbitmq/data
mkdir -p ../rabbitmq/log
chmod -R 777 ../rabbitmq

echo "${NC}👉 ${Green} build Docker compose ${lightGray}"
cd ..

docker-compose build
docker-compose up 
# chmod -R 777 ./initDB
# ./initDB/init.sh 127.0.0.1 3307 user password MCQ_DB