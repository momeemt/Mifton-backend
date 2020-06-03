module Api::V1
  class PostsController < ApplicationController

    # GET /posts
    def index
      @topics = Topic.all
      @drops = Drop.all
      # @posts = (@topics + @drops).uniq.sort_by { |v| v['updated_at'] }.reverse
      @posts = []
      @topics.each do |topic|
        user = User.find_by(id: topic.user_id)
        icon = user.icon_image
        if icon.present?
          user.icon_link = url_for(icon)
        end
        tmp = {
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
            :type => 'topic'
        }
        @posts.push(tmp)
      end
      @drops.each do |drop|
        user = User.find_by(id: drop.user_id)
        icon = user.icon_image
        if icon.present?
          user.icon_link = url_for(icon)
        end
        tmp = {
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
            :type => 'drop'
        }
        @posts.push(tmp)
      end
      @posts = @posts.sort_by { |post| post[:updated_at] }.reverse
      puts @posts
      render json: @posts
    end
  end
end
