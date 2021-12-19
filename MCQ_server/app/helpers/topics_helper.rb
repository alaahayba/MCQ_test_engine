module TopicsHelper


    def update_exam examData
        puts "topics helper update exam : ??"
        puts examData["topic_name"]
        begin
            @exam = TopicsExam.where("topic_name":examData["topic_name"])
            if @exam.length == 0
                puts "error: not found"
                return {error:"not found"}
            end
            raise Mongoid::Errors::DocumentNotFound unless @exam
            @exam.update("questions": examData["questions"],
            "answers": examData["answers"])
          rescue Mongoid::Errors::MongoidError => e
             logger.error(e.message)
        end
        return {exam:@exam}
    end
end
