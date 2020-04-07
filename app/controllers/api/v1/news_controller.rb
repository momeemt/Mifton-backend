module Api::V1
  class NewsController < ApplicationController
    before_action :set_news, only: [:show, :update, :destroy]

    # GET /news
    def index
      @news = Topic.all
      render json: @news
    end

    # GET /news/1
    def show
      render json: @news
    end

    # POST /news
    def create
      @news = Topic.new(news_params)

      if @news.save
        render json: @news, status: :created
      else
        render json: @news.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /news/1
    def update
      if @news.update(news_params)
        render json: @news
      else
        render json: @news.errors, status: :unprocessable_entity
      end
    end

    # DELETE /news/1
    def destroy
      @news.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = Topic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def news_params
      params.require(:news).permit(
          :title,
          :content,
          :user_id
      )
    end
  end
end
