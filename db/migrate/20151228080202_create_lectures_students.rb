class CreateLecturesStudents < ActiveRecord::Migration
  def change
      add_column :lectures_students, :student_id, :integer
      add_column :lectures_students, :lecture_id, :integer
      add_column :lectures_students, :test_result, :string
      add_column :lectures_students, :description, :text
  end
end
