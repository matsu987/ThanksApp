class CreateUserLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_likes do |t|
      t.references :sender, foreign_key: {to_table: :users}
      t.references :receiver, foreign_key: {to_table: :users}
      t.boolean :like, null: false, default: true

      t.timestamps
    end
  end
end