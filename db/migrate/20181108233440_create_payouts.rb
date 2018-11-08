class CreatePayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :payouts do |t|
      t.references :exchange, foreign_key: true
      t.string :timestamp
      t.float :amount

      t.timestamps
    end
  end
end
