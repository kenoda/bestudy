class RemoveSTestResultFromLecturesStudents < ActiveRecord::Migration
  def change
    remove_column :lectures_students, :test_result, :string
  end
end
