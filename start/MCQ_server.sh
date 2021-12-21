Green='\033[0;32m'
lightGray='\033[1;30m'
NC='\033[0m' # No Color

DB_USER = root
DB_PASSWORD: password
DB_NAME: app
DB_HOST: localhost
MONGO_HOST: localhost
RMQ_HOST: localhost
echo "${NC}👉 ${Green} start MCQ test server${lightGray}"
cd MCQ_server
gem update --system
gem install bundler:2.1.4
bundle install

bundle exec rails s -p 3000 -b '0.0.0.0'