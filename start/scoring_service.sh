DB_USER = root
DB_PASSWORD: password
DB_NAME: app
DB_HOST: localhost
RMQ_HOST: localhost

echo "${NC}👉 ${Green} startscoring service${lightGray}"
cd scoring_service
gem update --system
gem install bundler:2.1.4
gem install bunny
gem install json
gem install mysql2 

ruby calculate_score.rb