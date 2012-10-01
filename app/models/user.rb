class User < ActiveRecord::Base
  attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username
  attr_accessible :password, :password_confirmation
  acts_as_authentic

  has_and_belongs_to_many :transactions

  def transactions_contributed
    Transaction.all.select { |t| t.payer == id }
  end

  def transactions_expedited
    Transaction.all.select { |t| t.users.include? self }
  end

  # TODO optimalizuj
  def total_contribution
    transactions_contributed.map { |t| t.amount }.inject(:+) || 0
  end

  def total_expedience
    transactions_expedited.map { |t| t.amount_per_user }.inject(:+) || 0
  end
end
