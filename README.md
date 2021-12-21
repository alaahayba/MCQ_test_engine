# MCQ test engine

[MCQ_engine.com](https://github.com/alaahayba/MCQ_test_engine/)

### postman collection
[MCQ_postman](https://www.getpostman.com/collections/0b5ea09312ec7587dce7)
## Install

### Clone the repository

```shell
git clone https://github.com/alaahayba/zyda.git
cd zyda

```

### Check your Ruby version

```shell
ruby -v
```
The ouput should start with something like `ruby 2.5.1`

If not, install the right ruby version using command (it could take a while):
[install_Ruby](https://www.ruby-lang.org/en/documentation/installation/#apt)

```shell
https://www.ruby-lang.org/en/documentation/installation/#apt
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Project services dependencies

 - [mysql](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-18-04)
 - [mongo](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)
 - [rabbitMQ](https://www.rabbitmq.com/download.html)
 
### Project structure
 - initDB
 - MCQ_server
 - scorig_server
 - docker-compose.yml


### Initialize the database
  - initialize DB is in initDB
  - user:DBuser ,password:DBpassword ,app :DBname\
  for ex
 
```shell
  ./initDB/init.sh 127.0.0.1 3307 user password app
```

## start app  
### start one by one
- move to start folder
- change environment variable for each service
- then start

```shell
cd start
./MCQ_server.sh
./scoring_service.sh
```

### start docker
- [installDocker](https://docs.docker.com/engine/install/)
```shell
cd start
./docker_init.sh
```
at another terminal

```
 cd initDB
 ./start.sh 
```
