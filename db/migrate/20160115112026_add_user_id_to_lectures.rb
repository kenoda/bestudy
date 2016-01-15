class AddUserIdToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :user_id, :integer
  end
end
