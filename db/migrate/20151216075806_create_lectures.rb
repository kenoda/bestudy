class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|

      t.string :name
      t.string :season
      t.text :description
      t.timestamps null: false
    end
  end
end
