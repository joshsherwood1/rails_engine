class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
