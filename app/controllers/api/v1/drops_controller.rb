module Api::V1
  class DropsController < ApplicationController
    before_action :set_drop, only: [:show, :update, :destroy]

    # GET /drops
    def index
      results = []
      drops = Drop.all.order(created_at: :desc)
      drops.all.each do |drop|
        user = User.find_by(id: drop.user_id)
        icon = user.icon_image
        if icon.present?
          user.icon_link = url_for(icon)
        end
        g_hash = {
            :id => drop.id,
            :content => drop.content,
            :created_at => drop.created_at,
            :updated_at => drop.updated_at,
            :user => {
                :id => user.id,
                :user_id => user.user_id,
                :name => user.name,
                :email => user.email,
                :password_digest => user.password_digest,
                :created_at => user.created_at,
                :icon_link => user.icon_link,
            },
            :user_id => drop.user_id,
            :type => 'drop'
        }
        results.append(g_hash)
      end
      render json: results
    end

    # GET /drops/1
    def show
      user = User.find(@drop.user_id)
      result = {
          :id => @drop.id,
          :content => @drop.content,
          :created_at => @drop.created_at,
          :updated_at => @drop.updated_at,
          :user => user
      }
      render json: result
    end

    # POST /drops
    def create
      @drop = Drop.new(drop_params)

      if @drop.save
        @receive_drop = {
            :id => @drop.id,
            :content => @drop.content,
            :created_at => @drop.created_at,
            :updated_at => @drop.updated_at,
            :user => User.find_by(id: @drop.user_id),
            :type => 'drop'
        }
        render json: @receive_drop, status: :created
      else
        render json: @drop.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /drops/1
    def update
      if @drop.update(drop_params)
        render json: @drop
      else
        render json: @drop.errors, status: :unprocessable_entity
      end
    end

    # DELETE /drops/1
    def destroy
      @drop.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_drop
        @drop = Drop.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def drop_params
        params.require(:drop).permit(
            :content,
            :user_id
        )
      end
  end
end
