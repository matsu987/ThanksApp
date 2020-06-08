class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rank, null: false, default: 0
      t.boolean    :enrollment, null: false, default: true
      t.integer :status,             null: false, default: 0
      t.boolean :request, null: false, default: false

      t.timestamps
    end
  end
end
