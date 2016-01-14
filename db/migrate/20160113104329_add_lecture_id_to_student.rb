class AddLectureIdToStudent < ActiveRecord::Migration
  def change
    add_column :students, :lecture_id, :integer
  end
end
