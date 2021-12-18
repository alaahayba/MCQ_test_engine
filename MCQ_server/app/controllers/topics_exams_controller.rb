class TopicsExamsController < ApplicationController
  before_action :topics_exam_params, only: [:create]

  # GET /topics_exams or /topics_exams.json
  def index
    @topics_exams = TopicsExam.all
    puts  @topics_exams
   render json: { topics_exams:@topics_exams }, status: 200

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topics_exam
      @topics_exam = TopicsExam.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topics_exam_params
      params.require(:topics_exam).permit(:topic_name, :questions, :answers)
    end
end
