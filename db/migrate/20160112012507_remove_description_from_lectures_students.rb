class RemoveDescriptionFromLecturesStudents < ActiveRecord::Migration
  def change
    remove_column :lectures_students, :description, :text
  end
end
