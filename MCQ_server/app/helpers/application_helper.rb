module ApplicationHelper

  def auth_token
    reqToken = request.headers["token"]
    if (reqToken != "MCQ_admin")
      return false
    end
    return true
  end

  def get_topic(topic_name)
    @topics_exam = TopicsExam
      .where("topic_name": topic_name)
      .only(:topic_name, :questions)
    if @topics_exam.length != 0
      return { exam: @topics_exam }
    else
      { error: "topic not exist" }
    end
  end

  def get_topic_answers(topic_name)
    @topics_exam = TopicsExam
      .where("topic_name": topic_name)
      .only(:topic_name, :answers)
    if @topics_exam.length != 0
      return { exam: @topics_exam }
    else
      { error: "topic not exist" }
    end
  end

  def shuffle_exam(exam)
    @questions = exam[:questions]
    puts "shuffle questitons"
    exam[:questions] = exam[:questions].shuffle
    questions = exam[:questions]
    puts "shuffle answers"
    for quest in questions
      # puts quest
      quest[:choices] = quest[:choices].shuffle
      # puts quest[:choices]
    end
    return exam
  end

  # shuffle quest and answers
  def shuffle(arr)
    x = arr.length
    while x != 0
      new_arr = []
      rand_arr = (rand(x))
      x - -
 ##shuffle choices
        rand_arr[:choices] = rand_arr[:rand_arr].shuffle
      new_arr.push rand_arr
      arr.pop rand_arr
    end
    new_arr
  end

  def validate_answers(topic_answers, users_answers)
    puts "validate_answers"
    puts "topic answers", topic_answers
    puts "users answers", users_answers
    answes_results = {}
    topic_answers.each do |quesID, value|
      # puts "#{quesID}-----,#{value}"
      # puts users_answers["#{quesID}"]
      if (!users_answers["#{quesID}"])
        answes_results[quesID] = -1
      elsif (users_answers["#{quesID}"] == value)
        answes_results[quesID] = 1
      else
        answes_results[quesID] = 0
      end
    end

    puts "answes_results", answes_results
    return answes_results
  end

  def publish_answer_V0(queue_name, answers)
    puts "publish answers"
    puts answers, answers
    puts " ENV['RMQ_HOST']", ENV["RMQ_HOST"]
    connection =
      Bunny.new(host: ENV["RMQ_HOST"])
    #  Bunny.new(hostname: ENV['RMQ_HOST'] )
    # connection = Bunny.new
    connection.start
    channel = connection.create_channel
    queue = channel.queue(queue_name)
    channel.default_exchange.publish(answers.to_json, routing_key: queue.name)
    puts " [x] Sent answers"
    connection.close
  end

  def publish_answer(topic_answers, answers)
    Publisher.publish(topic_answers, answers)
  end
end
