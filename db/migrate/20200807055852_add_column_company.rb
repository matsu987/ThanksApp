class AddColumnCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :release_time, :string, null: false, default: "月末"
  end
end
