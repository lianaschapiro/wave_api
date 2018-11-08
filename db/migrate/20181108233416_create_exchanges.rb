class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|

      t.timestamps
    end
  end
end
