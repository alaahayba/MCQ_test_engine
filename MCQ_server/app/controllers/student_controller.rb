class StudentController < ApplicationController
  before_action :validate_enroll_body, only: [:enroll]
  before_action :filter_params, only: [:get_studen_result]

  
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
    puts ":enroll studet";
    exam=topic_data[:exam][0]
    examEnrollData = { "phone" => params[:student][:phone],
    "topic_name" => topic_data[:exam][0][:topic_name],
    "topic_id" => topic_data[:exam][0][:id]};

    @enroll_result=studen_exam_enroll(examEnrollData);
    puts "enroll_result:";
    puts @enroll_result;
    if(!@enroll_result[:status])
      render json: {error:"something went wrong", status:"serverError"}, status:500
      return
    end
     ### shuffle exam 
    shuffled_exam=helpers.shuffle_exam(exam)
    puts "topic_data:>>",topic_data

    render json: { status:"enrolled" ,"topic": topic_name, "exam": exam }, status: 200
  end

  def submit
    topic="IQ"
    exam=[1,2,3]
    
    render json: { "topic": topic, status: "submit" }, status: 200
  end

  def get_scores
    puts "get_scores"
    filter =[], values=[]  
    permit_filter=["topic_name","phone"]
    # for key in permit_filter do
    #   if(params[:topic_name])
    #      filter.push key
    # end

    puts filter 
    puts "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"

    puts params.values
    puts "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
    # if(params[:topic_name])
    # filter=["topic_name = ?", "#{params[:topic_name]}"]
    # end
    # if(params[:phone])
    #   filter=["phone = ?", "#{params[:phone]}"]
    # end
    puts params[:filter]
    @scores = StudentEnroll.where(filter)
    render json: { result:@scores }, status: 200
  end
  
  def student_average
    @average=StudentEnroll.where(phone: params[:phone]).average("score")
    render json: { result:@average }, status: 200
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

  def filter_params
    params.require(:filter).permit(:topic_name, :phone )
    params[:filter].permit!
    ActionController::Parameters.permit_all_parameters = true
  end

end
