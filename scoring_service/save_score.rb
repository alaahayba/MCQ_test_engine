require "mysql2"    
@db_host  = ENV["DB_HOST"]||"localhost"
@db_user  = ENV["DB_USER"]||"user"
@db_pass  = ENV["DB_PASS"]||"password"
@db_name = ENV["DB_APP"]||"app"

studen = Mysql2::Client.new(:host => @db_host, :username => @db_user,
     :password => @db_pass, :database => @db_name)
@cdr_result = studen.query("SELECT * from student_enrolls")
puts @cdr_result