class HomeController < ApplicationController
	def default
		if current_user
			@transactions = Transaction.all
			@transaction = Transaction.new
			@transaction.payer = current_user
			@users = User.all
			render 'logged'
		else
			@user_session = UserSession.new
			render 'unlogged'
		end
	end

	def conciliation
		unless current_user
			@user_session = UserSession.new
			render 'unlogged'
			return
		end

		users = User.all

		balances = []
		
		for u in users
			balances << [u.id, u.username, u.balance]
		end

		plus = balances.select { |b| b[2] >= 0 }.sort { |a, b| a[2] <=> b[2] }
		minus = balances.select { |b| b[2] < 0 }.sort { |a, b| a[2] <=> b[2] }

		index_plus = 0
		index_minus = 0

		@transactions = []
		while index_plus < plus.length && index_minus < minus.length
			p = plus[index_plus]
			m = minus[index_minus]
			# (-) dava prachy (+)
			money = p[2]
			if -m[2] < p[2]
				money = -m[2]
			end

			@transactions << {
				:from => User.find_by_id(m[0]),
				:to => User.find_by_id(p[0]),
				:amount => money
			}

			p[2] -= money
			m[2] += money

			index_plus += 1 if p[2] == 0
			index_minus += 1 if m[2] == 0
		end

		@rest = []
		for i in plus + minus
			if i[2] != 0
				@rest << {
					:user => User.find_by_id(i[0]),
					:amount => i[2]
				}
			end
		end
	end
end
