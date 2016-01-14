class RemoveStudentIdFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :student_id, :integer
  end
end
