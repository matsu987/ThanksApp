class CreateRecomendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recomendations do |t|
      t.references :recomender, foreign_key: {to_table: :users}
      t.references :electeder, foreign_key: {to_table: :users}
      t.boolean :decision, null: false, default: false

      t.timestamps
    end
  end
end
