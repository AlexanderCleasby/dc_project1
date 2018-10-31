class V1::SessionsController < ApplicationController
	
	def create
		start_session = false
		if params[:token].present?
			@user = User.find_by(confirmation_token: params[:token])
			start_session = new_with_token
		else
			@user = User.find_by(email: params[:email])
			start_session = new_with_password
		end
		
		if start_session
			render json: @user.as_json(only: [:email, :authentication_token, :hasFollowedAccounts]), status: :created
		else
			head(:unauthorized)
		end
	end
	
	def destroy
		current_user.authentication_token = nil
		if current_user.save
			head(:ok)
		else
			head(:unauthorized)
		end
	end
	
	private
		def new_with_token
			if @user&.confirmed?
				true
			end
		end
		
		def new_with_password
			if @user.confirmed? && @user&.valid_password?(params[:password])
				true
			end
		end
	
end