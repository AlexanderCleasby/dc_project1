class V1::SessionsController < ApplicationController
	
	def create
		@user = User.find_by(email: params[:email])
		#binding.pry
		if @user&.valid_password?(params[:password])
			render json: @user.as_json(only: [:email, :authentication_token, :hasFollowedAccounts]), status: :created
		else
			head(:unauthorized)
		end
	end
	
	def destroy
		current_user&.authentication_token = nil
		if current_user.save
			head(:ok)
		else
			head(:unauthorized)
		end
	end
	
end