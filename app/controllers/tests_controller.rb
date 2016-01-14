class TestsController < ApplicationController
  def new
    @lecture = Lecture.find(params[:lecture_id])
    @student = Student.find(params[:student_id])
    @test = Test.new
  end

  def create
    Test.create(create_params)
    @lecture = Lecture.find(params[:lecture_id])
    @student = Student.find(params[:student_id])
  end

  private
  def create_params
    params.require(:test).permit(:result, :description).merge(student_id: params[:student_id])
  end
end
