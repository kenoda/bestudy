class AddResultToTests < ActiveRecord::Migration
  def change
    add_column :tests, :result, :string
  end
end
