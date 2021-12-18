class TopicsController < ApplicationController
  before_action :topics_exam_params, only: [:topic_create,:topic_edit]

  def all
    @topics_exams = TopicsExam.all
    puts  @topics_exams
   render json: { topics_exams:@topics_exams }, status: 200
  end

  def topic_create
    topic={ 
    "topic_name" => params[:topics_exam][:topic_name],
    "questions"=> params[:topics_exam][:questions],
    "answers" => params[:topics_exam][:answers].to_h
    }
    @topics_exam = TopicsExam.new(topic)
    if @topics_exam.save
      render json: { message:"Topics exam was successfully created." }, status: 200
    else
      render json: {error:"something went wrong", status:"serverError"}, status:500
    end
  end

  def topic_edit

    topic_exam={ 
    "topic_name" => params[:topics_exam][:topic_name],
    "questions"=> params[:topics_exam][:questions],
    "answers" => params[:topics_exam][:answers].to_h
    }
    updateExam=helpers.update_exam(topic_exam)
    puts "updateExam>>>>>>>>>>>>>>>>>"
    puts updateExam 
    if (!updateExam[:error])
      render json: { message:"Topics exam was successfully update." }, status: 200
    else
      render json: {error:updateExam[:error], status:"serverError"}, status:404
    end

  end

  private

  def topics_exam_params
    puts params
    params.require(:topics_exam).permit(:topic_name,:questions,:answers);
    params.require(:topics_exam).permit(:answers);
    # params[:topics_exam][:answers].to_h
    params[:topics_exam][:answers].permit!

    # ActionController::Parameters.permit_all_parameters = true

  end
end
