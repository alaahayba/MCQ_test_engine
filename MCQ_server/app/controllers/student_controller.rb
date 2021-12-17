class StudentController < ApplicationController
  before_action :validate_enroll_body, only: [:enroll]

  def enroll
    topic="IQ"
    exam=[1,2,3]
    puts request.body
    ## TODO save user data
    ##Mongo check topic exist
    ## save enrolled topic
    ### shuffle examp 
    ##return to end user
    puts ">>>>>>>>>>>>>>>>>"

    render json: { status:"enrolled" ,"topic": topic, "exam": exam }, status: 200
  end


  def submit
    topic="IQ"
    exam=[1,2,3]
    
    render json: { "topic": topic, status: "submit" }, status: 200
  end

  private


  def validate_enroll_body
    # strong parameters
    params.require(:user).permit(:name,:age, :phone, :topic)
  end

end
