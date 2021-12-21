require "mysql2"
@db_host = ENV["DB_HOST"] || "localhost"
@db_user = ENV["DB_USER"] || "user"
@db_pass = ENV["DB_PASSWORD"] || "password"
@db_name = ENV["DB_NAME"] || "app"

@conn = Mysql2::Client.new(:host => @db_host, :username => @db_user,
                          :password => @db_pass, :database => @db_name)

def update_score(enroll_id, phone, score)
  puts "update user #{phone} with score #{score} for enrollment #{enroll_id}"
  statement = @conn.prepare("UPDATE student_enrolls SET score=? WHERE phone=? and id=?")
  result = statement.execute(score, phone, enroll_id)
  return result;
end

puts "update Score"
