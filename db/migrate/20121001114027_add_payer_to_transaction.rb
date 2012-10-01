class AddPayerToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :payer, :int # TODO: references
  end
end
