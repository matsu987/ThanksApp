class CreateThanks < ActiveRecord::Migration[5.2]
  def change
    create_table :thanks do |t|
      t.text :text, null: false
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.boolean :transmission_status, null: false, default: false
      t.boolean :reception_status, null: false, default: false

      t.timestamps
    end
  end
end
