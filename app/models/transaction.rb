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
	attr_reader :user_list

	def user_list=(value)
		if value.is_a? Hash
			@user_list = value.keys
		elsif value.is_a? Array
			@user_list = value
		else
			raise "Unknown user_list new value type!"
		end
	end

	attr_accessible :user_list
	after_save :update_users

	def nice_user_list
		users.map { |user| user.username }.to_a.join ", "
	end

	private

	def update_users
		users.delete_all
		selected = user_list.nil? ? [] : user_list.collect{|id| User.find_by_id(id.to_i)}
		selected.each { |user| self.users << user }
	end
end
