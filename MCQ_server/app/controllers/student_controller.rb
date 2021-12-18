class StudentController < ApplicationController
  before_action :validate_enroll_body, only: [:enroll]

  def enroll
  
    ## TODO save user data
    puts ":save studet"
    @save_result=save_student;
    puts @save_result
    ##Mongo check topic exist
    topic_name=params[:topic]
    topic_data=helpers.get_topic(topic_name);
    puts "topic_data:>>",topic_data
    if(topic_data[:error])
      render json: {error:"cannot find topic", status:"userError"}, status:404
      return
    end
    ## save enrolled topic
    puts ":enroll studet"
    examEnrollData = { "phone" => params[:student][:phone],
    "topic_name" => "IQ","topic_id" => "1111111"};
    @enroll_result=studen_exam_enroll(examEnrollData);
    puts "enroll_result:";
    puts @enroll_result;
    if(!@enroll_result[:status])
      render json: {error:"something went wrong", status:"serverError"}, status:500
      return
    end
     ### shuffle exam 
    exam=topic_data[:exam]
    shuffled_exam=helpers.shuffle_exam(exam)
    puts "topic_data:>>",topic_data

    render json: { status:"enrolled" ,"topic": topic_name, "exam": shuffled_exam }, status: 200
  end


  def submit
    topic="IQ"
    exam=[1,2,3]
    
    render json: { "topic": topic, status: "submit" }, status: 200
  end

  private


  def validate_enroll_body
    # strong parameters
    params.require(:student).permit(:name,:age, :phone)
    params.require(:topic)
  end

  def save_student
    @student_phone = Student.where(phone: student_params[:phone])
    if @student_phone == []
      @student = Student.new(student_params)
      if @student.save
       return true
      else
        render json: @student.errors, status: :unprocessable_entity
      end
    # the student exist in data base just enroll him
    return true
    end
  end

  def studen_exam_enroll(examEnrollData)
      @student_enroll = StudentEnroll.new(examEnrollData)
      if @student_enroll.save
       return {status:true}
      else
        puts "::::::::::::Error::::::::::::"
        puts @student_enroll;
        error = {json: @student_enroll.errors};
        return {errors:error ,status:false}
      end
  end
  # Only allow a trusted parameter .
  def student_params
      params.require(:student).permit(:name,:age, :phone)
  end

end
