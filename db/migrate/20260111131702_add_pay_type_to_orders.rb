class AddPayTypeToOrders < ActiveRecord::Migration[8.0]
  def change
    remove_column :orders, :pay_type, :string
    add_reference :orders, :pay_type, null: false, foreign_key: true
  end
end
