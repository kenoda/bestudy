class RemoveLectureIdFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :lecture_id, :integer
  end
end
