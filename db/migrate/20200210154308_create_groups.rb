class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string "name", null: false, index: true
      t.string "ancestry"

      t.timestamps
    end
  end
end
