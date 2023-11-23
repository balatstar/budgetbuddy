class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.decimal :amount
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
