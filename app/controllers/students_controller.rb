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
    # binding.pry
    @student = Student.find(params[:id])
    @lecture = Lecture.find(params[:lecture_id])
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
    
    # binding.pry
  end

  private
  def create_params
    params.require(:student).permit(:name, :description).merge(lecture_id: params[:lecture_id])
  end

end
