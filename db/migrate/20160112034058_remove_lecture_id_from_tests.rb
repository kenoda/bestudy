class RemoveLectureIdFromTests < ActiveRecord::Migration
  def change
    remove_column :tests, :lecture_id, :integer
  end
end
