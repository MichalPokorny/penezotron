class RemoveTimestampsFromTransactionsUsers < ActiveRecord::Migration
  def up
    change_table :transactions_users do |t|
      t.remove_timestamps
    end
  end
end
