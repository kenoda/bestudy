class LecturesController < ApplicationController
  def index
    @lectures = Lecture.order('id ASC') #最新順に教室を並べる
  end

  def new
  end

  def create
    Lecture.create(name: params[:name], season: params[:season], description: params[:description])
  end

  def show
    @lecture = Lecture.find(params[:id])
    # @students = Student.all ここで多対多の関係を使う必要がある
  end

  private
  def lecture_params
    params.permit(:name, :season, :description)
  end

end
