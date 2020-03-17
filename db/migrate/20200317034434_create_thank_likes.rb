class CreateThankLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :thank_likes do |t|
      t.references :sender, foreign_key: {to_table: :users}
      t.references :thank, foreign_key: true
      t.boolean :like, null:false, default: true

      t.timestamps
    end
  end
end