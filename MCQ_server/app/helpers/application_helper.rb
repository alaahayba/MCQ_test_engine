
module ApplicationHelper
    def get_topic(topic_name)
      @topics_exam = TopicsExam.where("topic_name":topic_name).only(:topic_name,:questions);
      if @topics_exam.length.to_i != 0
        return {exam:@topics_exam}
      else
          {error:"topic not exist"}
      end
    end

    def shuffle_exam(exam)
      @questions = exam[:questions]
        puts "shuffle questitons";
        puts "shuffle answers"
        return exam
    end
end
