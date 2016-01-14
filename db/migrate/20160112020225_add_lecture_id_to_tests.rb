class AddLectureIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :lecture_id, :integer
  end
end
