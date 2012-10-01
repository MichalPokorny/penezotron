class CreateTransactionsUsers < ActiveRecord::Migration
  def up
    create_table :transactions_users, :id => false do |t|
      t.references :transaction
      t.references :user
      t.timestamps
    end
  end

  def down
    drop_table :transactions_users
  end
end
