# MCQ test engine

[MCQ_engine.com](https://github.com/alaahayba/zyda/)

## Install

### Clone the repository

```shell
git clone https://github.com/alaahayba/zyda.git
cd project
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

### project structure



### Initialize the database

```shell
./initDB/init.sh 127.0.0.1 3307 user password app
```

## Serve

```shell
rails s
```
