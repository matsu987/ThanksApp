class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, null: false, index: true
      t.string :post_number
      t.text :address
      t.string :phone_number

      t.timestamps
    end
  end
end