module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :set_optional_user_datum, only: [:update]

    # GET /users
    def index
      @users = User.all.order(created_at: :desc)
      render json: @users
    end

    # GET /users/1
    def show
      icon = @user.icon_image
      if icon.present?
        @user.icon_link = url_for(icon)
      end
      render json: @user
    end

    # GET /users/user_id/1
    def acquisition_at_user_id
      user = User.find_by_user_id(params[:id])
      if user.present?
        icon = user.icon_image
        if icon.present?
          user.icon_link = url_for(icon)
        end
        render json: user
      else
        render json: 'user not found', status: :not_found
      end
    end

    # POST /users
    def create
      @user = User.new(user_params)
      @user.icon_parse_base64(user_params[:icon])
      if @user.save
        @user.build_user_job
        @user.build_optional_user_datum
        @user.send_activation_email
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      @user.icon_parse_base64(user_params[:icon])
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

      def set_optional_user_datum
        @optional_user_datum = OptionalUserDatum.find_by(user_id: params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.fetch(:user, {}).permit(
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