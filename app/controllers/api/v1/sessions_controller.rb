module Api::V1
  class SessionsController < ApplicationController
    def create
      user = User.find_by(user_id: params[:session][:user_id].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        render json: user, status: :created
      else
        render json: params, status: :unprocessable_entity
      end
    end

    def destroy
      log_out
    end
  end
end
