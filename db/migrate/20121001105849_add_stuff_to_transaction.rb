class AddStuffToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :name, :string
    add_column :transactions, :amount, :int
    add_column :transactions, :notes, :string
  end
end
