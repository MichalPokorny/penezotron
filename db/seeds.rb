# encoding: UTF-8

users = [ "prvak", "tomi", "havri" ]
users.each do |u|
	User.create :username => u,
		:password => 'heslo',
		:password_confirmation => 'heslo',
		:email => u.parameterize + '@example.com'
end
