
module ApplicationHelper
    def get_topic(topic_name)
        if topic_name == "IQ"
          return {exam:[1,2,3]}
        else
          {error:"topic not exist"}
        end
    end

    def shuffle_exam(exam)
        puts "shuffle questitons";
        puts "shuffle answers"
        return exam
    end
end
