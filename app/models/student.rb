class Student < ActiveRecord::Base
  # has_many :lectures_students
  # has_many :lectures, through: :lectures_students
  has_many :tests
  belongs_to :lecture
end
