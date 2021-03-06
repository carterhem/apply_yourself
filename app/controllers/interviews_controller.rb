class InterviewsController < ApplicationController

  before_action :authorize
  
  def new
    @interview = Interview.new
    @app = App.find(params[:app_id])
  end

  def create
    @app = App.find(params[:app_id])
    @interview = @app.interviews.new(interview_params)

    if @interview.save!
      flash[:success] = "New app successfully added!"
      redirect_to "/apps/#{@app.id}"
    else
      flash.now[:error] = "interview creation failed"
      render :new
    end
  end
  
  def edit
    @interview = Interview.find(params[:id])
  end 
  
  def update
    @interview = Interview.find(params[:id])

    if @interview.update(interview_params)
      redirect_to "/apps/#{@interview.app_id}"
    else
      render :edit
    end
  end

  def interview_params 
    params.require(:interview).permit(:interview_number, :interview_date, :interview_type, :interview_notes, :completed)
  end
  
end


