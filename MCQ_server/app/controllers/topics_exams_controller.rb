class TopicsExamsController < ApplicationController
  before_action :set_topics_exam, only: %i[ show edit update destroy ]

  # GET /topics_exams or /topics_exams.json
  def index
    @topics_exams = TopicsExam.all
    puts  @topics_exams
   render json: { topics_exams:@topics_exams }, status: 200

  end

  # GET /topics_exams/new
  def new
    @topics_exam = TopicsExam.new
  end

  # GET /topics_exams/1/edit
  def edit
  end

  # POST /topics_exams or /topics_exams.json
  def create
    @topics_exam = TopicsExam.new(topics_exam_params)

    respond_to do |format|
      if @topics_exam.save
        format.html { redirect_to @topics_exam, notice: "Topics exam was successfully created." }
        format.json { render :show, status: :created, location: @topics_exam }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topics_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics_exams/1 or /topics_exams/1.json
  def update
    respond_to do |format|
      if @topics_exam.update(topics_exam_params)
        format.html { redirect_to @topics_exam, notice: "Topics exam was successfully updated." }
        format.json { render :show, status: :ok, location: @topics_exam }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topics_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics_exams/1 or /topics_exams/1.json
  def destroy
    @topics_exam.destroy
    respond_to do |format|
      format.html { redirect_to topics_exams_url, notice: "Topics exam was successfully destroyed." }
      format.json { head :no_content }
    end
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
