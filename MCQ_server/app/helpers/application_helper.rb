
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
        exam[:questions]=exam[:questions].shuffle;
        questions=exam[:questions]
        puts "shuffle answers"
        for quest in questions do
          puts  quest
          quest[:choices]=quest[:choices].shuffle;
          puts  quest[:choices]
        end
        return exam
    end

    # shuffle quest and answers
  def shuffle arr
      x = arr.length
      while x != 0
        new_arr = []
        rand_arr = (rand(x))
        x--
        ##shuffle choices 
        rand_arr[:choices]=rand_arr[:rand_arr].shuffle
        new_arr.push rand_arr
        arr.pop rand_arr
     end
   new_arr
  end
  

end
