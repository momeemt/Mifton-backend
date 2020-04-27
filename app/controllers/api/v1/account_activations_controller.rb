module Api::V1
  class AccountActivationsController < ApplicationController
    def edit
      user = User.find_by(email: params[:email])
      if user && !user.activated? && user.authenticated?(:activation, params[:id])
        user.activate
        log_in user
        render json: user, status: 200
      else
        render json: user, status: :unprocessable_entity
      end
    end
  end
end
