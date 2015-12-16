class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end

  def new
  end

  def create
    Lecture.create(name: params[:name], season: params[:season], description: params[:description])
  end

  private
  def lecture_params
    params.permit(:name, :season, :description)
  end

end
