class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.text :address
      t.integer :price
      t.string :state, default: 'pending'

      t.index :state

      t.timestamps
    end
  end
end
