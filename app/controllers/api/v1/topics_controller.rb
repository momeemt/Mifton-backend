module Api::V1
  class TopicsController < ApplicationController
    before_action :set_topic, only: [:show, :update, :destroy]

    # GET /topics
    def index
      results = []
      topics = Topic.all.order(created_at: :desc)
      topics.all.each do |topic|
        user = User.find_by(id: topic.user_id)
        icon = user.icon_image
        if icon.present?
          user.icon_link = url_for(icon)
        end
        g_hash = {
            :id => topic.id,
            :title => topic.title,
            :content => topic.content,
            :created_at => topic.created_at,
            :updated_at => topic.updated_at,
            :user => {
                :id => user.id,
                :user_id => user.user_id,
                :name => user.name,
                :email => user.email,
                :password_digest => user.password_digest,
                :created_at => user.created_at,
                :icon_link => user.icon_link,
            },
            :user_id => topic.user_id,
            :type => 'topic'
        }
        results.append(g_hash)
      end
      render json: results
    end

    # GET /topics/1
    def show
      user = User.find(@topic.user_id)
      result = {
          :id => @topic.id,
          :content => @topic.content,
          :created_at => @topic.created_at,
          :updated_at => @topic.updated_at,
          :user => user
      }
      render json: result
    end

    # POST /topics
    def create
      @topic = Topic.new(topic_params)

      if @topic.save
        @receive_topic = {
            :id => @topic.id,
            :content => @topic.content,
            :created_at => @topic.created_at,
            :updated_at => @topic.updated_at,
            :user => User.find_by(id: @topic.user_id),
            :type => 'topic'
        }
        render json: @receive_topic, status: :created
      else
        render json: @topic.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /topics/1
    def update
      if @topic.update(topic_params)
        render json: @topic
      else
        render json: @topic.errors, status: :unprocessable_entity
      end
    end

    # DELETE /topics/1
    def destroy
      @topic.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def topic_params
      params.require(:topic).permit(
      :title,
          :content,
          :user_id
      )
    end
  end
end
