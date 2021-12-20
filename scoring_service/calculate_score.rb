#!/usr/bin/env ruby
require "bunny"
require "json"
require  "./save_score"
def calculate_score(answers)
  puts "start calculate score for answers:", answers
  score = 0
  puts "==>Answers::>>", answers
  answers.each do |quesID, value|
    puts value
    if (value == 1)
      score += 2
    elsif (value == 0) #wrrong answer
      score -= 0.5
    end
  end
  return score
end

def save_score(user_data, score)
end

def start
  puts "RMQ host>>>", ENV["RMQ_HOST"]
  connection = Bunny.new(host: ENV["RMQ_HOST"],
                         automatically_recover: false)
  connection.start
  queue_name = ENV["QUEUE_NAME"] || "student_answers"
  puts queue_name
  channel = connection.create_channel
  queue = channel.queue(queue_name)

  begin
    puts " [*] Waiting for messages. To exit press CTRL+C"
    queue.subscribe(manual_ack: true, block: true) do |_delivery_info, _properties, body|
      puts " [x] Received #{body}"
      body = JSON.parse(body)
      result = calculate_score(body["answers_validations"])
      puts "calculated Result", result
      #   channel.ack(delivery_info.delivery_tag);

    end
  rescue Interrupt => _
    connection.close

    exit(0)
  end
end

puts "start consuming"
start
