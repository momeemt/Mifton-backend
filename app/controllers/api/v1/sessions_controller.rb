module Api::V1
  class SessionsController < ApplicationController
    def create
      user = User.find_by(user_id: params[:session][:user_id].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          render json: user, status: :created
        else
          render json: params, status: 401 #認証されてない
        end
      else
        render json: params, status: :unprocessable_entity
      end
    end

    def destroy
      log_out if logged_in?
    end
  end
end
