class HomeController < ApplicationController
	def default
		if current_user
			@transactions = Transaction.all
			@transaction = Transaction.new
			@users = User.all
			render 'logged'
		else
			@user_session = UserSession.new
			render 'unlogged'
		end
	end
end
