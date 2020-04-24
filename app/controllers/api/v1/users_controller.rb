module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    wrap_parameters :user, include: [:name, :user_id, :email, :password, :password_confirmation]

    # GET /users
    def index
      @users = User.all.order(created_at: :desc)
      render json: @users
    end

    # GET /users/1
    def show
      render json: @user
    end

    # GET /users/user_id/1
    def acquisition_at_user_id
      @user = User.find_by_user_id(params[:id])
      render json: @user
    end

    # POST /users
    def create
      @user = User.new(user_params)
      @user.build_user_job
      @user.build_optional_user_datum

      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      @user.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(
          :name,
          :user_id,
          :email,
          :password,
          :password_confirmation,
          :icon,
          :header
        )
      end
  end
end
