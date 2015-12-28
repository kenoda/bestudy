class Lecture < ActiveRecord::Base
  belongs_to :user
  has_many :lectures_students
  has_many :students, through: :lectures_students
end
