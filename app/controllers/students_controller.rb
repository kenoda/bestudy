class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @lecture = Lecture.find(params[:lecture_id])
    @student = Student.new
  end

  def create
    Student.create(create_params)
    @lecture = Lecture.find(params[:lecture_id])
  end

  def show
    @student =Student.find(params[:id])
    @lecture = Lecture.find(params[:id])
    @test = Test.all
    @bfilter = Bfilter.new
  end

  private
  def create_params
    params.require(:student).permit(:name, :description).merge(lecture_id: params[:lecture_id])
  end

end
