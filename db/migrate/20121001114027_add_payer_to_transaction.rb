class AddPayerToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :payer, :user
  end
end
