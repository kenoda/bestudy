class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
  end

  def create
    Student.create(name: params[:name], description: params[:description])
  end

  private
  def lecture_params
    params.permit(:name, :description)
  end

end
