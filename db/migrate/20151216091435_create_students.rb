class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|

      t.string :name
      t.text :description #生徒の説明
      t.timestamps null: false
    end
  end
end
