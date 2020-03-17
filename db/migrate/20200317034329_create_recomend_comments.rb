class CreateRecomendComments < ActiveRecord::Migration[5.2]
  def change
    create_table :recomend_comments do |t|
      t.references :recomendation, foreign_key: true
      t.references :user, foreign_key: true
      t.text :text, null: false

      t.timestamps
    end
  end
end