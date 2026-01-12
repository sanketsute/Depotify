class CreatePayTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :pay_types do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.timestamps
    end

    add_index :pay_types, :code, unique: true
  end
end
