class AddColumnThanks < ActiveRecord::Migration[5.2]
  def change
    add_reference :thanks, :group, null: false, foreign_key: true
    add_column :thanks, :release, :boolean, null: false, default: false
  end
end
