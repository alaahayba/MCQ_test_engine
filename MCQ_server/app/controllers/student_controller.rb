class StudentController < ApplicationController
  before_action :validate_enroll_body, only: [:enroll]
  before_action :filter_params, only: [:get_scores]
  before_action :validate_submit_body, only: [:submit]

  def enroll
    ## TODO save user data
    puts ":save studet"
    @save_result = save_student
    puts @save_result
    ##Mongo check topic exist
    topic_name = params[:topic]
    topic_data = helpers.get_topic(topic_name)
    puts "topic_data:>>", topic_data
    if (topic_data[:error])
      render json: { error: "cannot find topic", status: "userError" }, status: 404
      return
    end
    ## save enrolled topic
    puts ":enroll studet"
    exam = topic_data[:exam][0]
    examEnrollData = { "phone" => params[:student][:phone],
                       "topic_name" => topic_data[:exam][0][:topic_name],
                       "topic_id" => topic_data[:exam][0][:id] }

    @enroll_result = studen_exam_enroll(examEnrollData)
    puts "enroll_result:"
    puts @enroll_result
    if (!@enroll_result[:status])
      render json: { error: "something went wrong", status: "serverError" }, status: 500
      return
    end
    ### shuffle exam
    shuffled_exam = helpers.shuffle_exam(exam)
    puts "topic_data:>>", topic_data

    render json: { status: "enrolled",
                   "enroll_id": @enroll_result[:userEnroll][:id],
                   "topic": topic_name, "exam": exam }, status: 200
  end

  def submit
    phone = params[:phone]
    enroll_id = params[:enroll_id]
    topic_name = params[:topic]

    #check if user is enrolled
    @is_student_enrolled = StudentEnroll
      .where(id: enroll_id,
             phone: phone, topic_name: topic_name)

    puts "enrolled result", @is_student_enrolled
    if @is_student_enrolled.length.to_i == 0
      render json: { status: "error", message: "no enrollment found" }, status: 404
      return
    end

    ##### TODO prevent multiple submit

    #Mongo get topic
    topic_answers = helpers.get_topic_answers(topic_name)
    puts "topic_answers:>>"
    puts topic_answers[:exam][0][:answers]

    if (topic_answers[:error])
      render json: { error: "cannot find topic", status: "systemError" }, status: 404
      return
    end
    # save answers
    # @save_answers_result = save_answers_student
    #validat answers is true or false
    users_answers = params[:answers]
    topic_answers=topic_answers[:exam][0][:answers]
    answers_validations = helpers.validate_answers( topic_answers, users_answers)
    puts answers_validations
    # push answer answers_validations to RMQ

    render json: { "topic": topic_name, status: "submit" }, status: 200
  end

  def get_scores
    puts "get_scores"
    puts params
    @scores = StudentEnroll.
      where(phone: params[:phone], topic_name: params[:topic_name])
    render json: { result: @scores }, status: 200
  end

  def student_average
    @average = StudentEnroll.where(phone: params[:phone]).average("score")
    render json: { result: @average }, status: 200
  end

  private

  def validate_enroll_body
    # strong parameters
    params.require(:student).permit(:name, :age, :phone)
    params.require(:topic)
  end

  def validate_submit_body
    # strong parameters
    params.require (:phone)
    params.require(:enroll_id)
    params.require (:answers)
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
      return { status: true, userEnroll: @student_enroll }
    else
      puts "::::::::::::Error::::::::::::"
      puts @student_enroll
      error = { json: @student_enroll.errors }
      return { errors: error, status: false }
    end
  end

  # Only allow a trusted parameter .
  def student_params
    params.require(:student).permit(:name, :age, :phone)
  end

  def filter_params
    params.require(:topic_name)
    params.require(:phone)
  end
end
