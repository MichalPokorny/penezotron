class TransactionsController < ApplicationController
	# GET /transactions
	# GET /transactions.json
	def index
		@transactions = Transaction.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @transactions }
		end
	end

	# GET /transactions/1
	# GET /transactions/1.json
	def show
		@transaction = Transaction.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @transaction }
		end
	end

	# GET /transactions/1/edit
	def edit
		@transaction = Transaction.find(params[:id])
	end

	# POST /transactions
	# POST /transactions.json
	def create
		payer = params[:transaction][:payer].to_i
		params[:transaction].delete :payer
		@transaction = Transaction.new(params[:transaction])
		if payer
			@transaction.payer = payer
		else
			@transaction.payer = current_user.id
		end

		respond_to do |format|
			if @transaction.save
				format.html { redirect_to :home, notice: 'Transaction was successfully created.' }
				format.json { render json: @transaction, status: :created, location: @transaction }
			else
				format.html { redirect_to :home }
				format.json { render json: @transaction.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /transactions/1
	# PUT /transactions/1.json
	def update
		@transaction = Transaction.find(params[:id])

		respond_to do |format|
			if @transaction.update_attributes(params[:transaction])
				format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @transaction.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /transactions/1
	# DELETE /transactions/1.json
	def destroy
		@transaction = Transaction.find(params[:id])
		@transaction.destroy

		respond_to do |format|
			format.html { redirect_to transactions_url }
			format.json { head :no_content }
		end
	end
end
