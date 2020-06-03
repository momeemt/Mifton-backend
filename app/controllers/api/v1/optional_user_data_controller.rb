module Api::V1
  class OptionalUserDataController < ApplicationController
    before_action :set_optional_user_datum, only: [:show, :update]

    # GET /optional_user_data/1
    def show
      render json: @optional_user_datum
    end

    # PATCH/PUT /optional_user_data/1
    def update
      if @optional_user_datum.present?
        if @optional_user_datum.update(optional_user_datum_params)
          render json: @optional_user_datum
        else
          render json: @optional_user_datum.errors, status: :unprocessable_entity
        end
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_optional_user_datum
      @optional_user_datum = OptionalUserDatum.find_by(user_id: params[:id])
    end

    def optional_user_datum_params
      params.require(:optional_user_datum).permit(
          :profile,
          :website,
          :location,
          :birthday,
          :publish_birthday,
          :twitter_id,
          :lobi_id,
          :github_id,
          :discord_id
      )
    end
  end
end