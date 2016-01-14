class AddStudentIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :student_id, :integer
  end
end
