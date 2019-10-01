class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.bigint :invoice_id
      t.bigint :credit_card_number
      t.string :credit_card_expiration_date, default: nil
      t.string :result
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
