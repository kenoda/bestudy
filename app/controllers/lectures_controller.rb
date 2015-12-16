class LecturesController < ApplicationController
  def index
    @name = Lecture.all
  end

  def new
  end
end
