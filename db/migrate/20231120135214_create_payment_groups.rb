class CreatePaymentGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_groups do |t|
      t.belongs_to :payment
      t.belongs_to :group

      t.timestamps
    end
  end
end
