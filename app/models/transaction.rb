class Transaction < ActiveRecord::Base
  validates :name, :presence => true
  validates :amount, :presence => true, :numericality => { :greater_than => 0 }
  validate :has_at_least_one_target
  validates :payer, :presence => true

  # attr_accessible :title, :body
  has_and_belongs_to_many :users

  attr_accessible :name, :amount, :notes

  def has_at_least_one_target
    true # zatim
  end

  def amount_per_user
    amount / users.count
  end

  attr_accessor :user_list
  attr_accessible :user_list
  after_save :update_users

  def nice_user_list
    users.map { |user| user.username }.to_a.join ", "
  end

  private

  def update_users
    users.delete_all
    selected = user_list.nil? ? [] : user_list.collect{|id| User.find_by_id(id)}
    selected.each { |user| self.users << user }
  end
end
