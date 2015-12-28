class LecturesStudentsController < ApplicationController
  belongs_to :student
  belongs_to :lecture
end
