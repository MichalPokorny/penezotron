# encoding: UTF-8

class User < ActiveRecord::Base
	HUMAN_ATTRIBUTE_NAMES = {
		:username => "Uživatelské jméno",
		:email => "E-mail",
		:password => "Heslo",
		:password_confirmation => "Potvrzení hesla"
	}

	class << self
		def human_attribute_name attribute_name, options = {}
			HUMAN_ATTRIBUTE_NAMES[attribute_name.to_sym] || super
		end
	end

	attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username
	attr_accessible :password, :password_confirmation
	acts_as_authentic

	has_and_belongs_to_many :transactions

	def transactions_contributed
		Transaction.where(payer: id)
	end

	def transactions_expedited
		Transaction.all.select { |t| t.users.include? self }
	end

	def total_contribution
		Rails.cache.fetch "user/#{id}/total_contribution", expires_in: 1.minute do
			transactions_contributed.map { |t| t.amount }.inject(:+) || 0
		end
	end

	def total_expedience
		Rails.cache.fetch "user/#{id}/total_expedience", expires_in: 1.minute do
			transactions_expedited.map { |t| t.amount_per_user }.inject(:+) || 0
		end
	end

	def balance
		total_contribution - total_expedience
	end

	# TODO: FUJ, proc tohle je potreba?
	def to_i
		id
	end
end
