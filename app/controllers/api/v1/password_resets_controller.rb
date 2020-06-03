module Api::V1
  class PasswordResetsController < ApplicationController
    before_action :get_user, only: [:edit, :update]
    before_action :valid_user, only: [:edit, :update]
    before_action :check_expiration, only: [:edit, :update]

    def new
    end

    def create
      @user = user.find_by(email: params[:password_reset][:email].downcase)
      if @user
        @user.create_reset_digest
        @user.send_password_reset_email
        # 送信した を示すリクエストを返す
      else
        # emailないぞ を返す
      end
    end

    def edit
    end

    def update
      if params[:user][:password].empty?
        @user.errors.add(:password, :blank)
        # パスワードが空であると言うリクエストを返す
      elsif @user.update_attributes(user_params)
        log_in @user
        @user.update_attribute(:reset_digest, nil)
        # 成功リクエストを返す
      else
        # 無効なパスワードであるリクエストを返す
      end
    end

    private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
        # 正しくないユーザーなのでリクエストを返す
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        # トークンが期限切れだというリクエストを返す
      end
    end
  end
end
