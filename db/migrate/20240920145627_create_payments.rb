class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.references :subscription, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
