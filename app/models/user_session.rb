# encoding: UTF-8

class UserSession < Authlogic::Session::Base
	def to_key
		new_record? ? nil : [ self.send(self.class.primary_key) ]
	end

	def persisted?
		false
	end

	class << self
		def human_attribute_name attribute_name, options = {}
			HUMAN_ATTRIBUTE_NAMES[attribute_name.to_sym] || super
		end
	end

	HUMAN_ATTRIBUTE_NAMES = {
		:username => "Uživatel",
		:password => "Heslo"
	}
end
