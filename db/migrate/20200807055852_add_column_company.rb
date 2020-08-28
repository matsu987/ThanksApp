class AddColumnCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :release_time, :datetime, null: false
  end
end
