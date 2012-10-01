class User < ActiveRecord::Base
  attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username
  attr_accessible :password, :password_confirmation
  acts_as_authentic

  has_and_belongs_to_many :transactions

  # TODO optimalizuj
  def total_contribution
    Transaction.all.map { |transaction|
      (transaction.payer == id) ? transaction.amount : 0
    }.inject(:+)
  end

  def total_expedience
    Transaction.all.map { |transaction|
      (transaction.users.include? self) ? transaction.amount_per_user : 0
    }.inject(:+)
  end
end
