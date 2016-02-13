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
    @student = Student.find(params[:id])
    # binding.pry
    # @lecture = Lecture.find(params[:lecture_id])
    @lecture_id = @student.lecture_id
    @lecture = Lecture.find(@lecture_id)
    @test = Test.all
    bfilter = Bfilter.new
    lecture_tests = []
    students = @lecture.students

    students.each do |student|
      lecture_tests << student.tests
    end
    lecture_tests.flatten.each do |test|
      bfilter.train(test.description, test.result)
      if test.description == nil
        @test.description = ""
      else
        @forecast = bfilter.classifier(@test[0].description)
      end
    end
    
  end

  private
  def create_params
    params.require(:student).permit(:name, :description, :id).merge(lecture_id: params[:lecture_id])
  end

end
