class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.date :transaction_date
      t.decimal :value
      t.string :tax_number
      t.string :card
      t.time :transaction_time
      t.string :responsible_name
      t.string :store

      t.timestamps
    end
  end
end
