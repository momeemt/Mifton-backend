module Api::V1
  class PostsController < ApplicationController

    # GET /posts
    def index
      @topics = Topic.all
      @drops = Drop.all
      # @posts = (@topics + @drops).uniq.sort_by { |v| v['updated_at'] }.reverse
      @posts = []
      @topics.each do |topic|
        tmp = {
            :id => topic.id,
            :title => topic.title,
            :content => topic.content,
            :created_at => topic.created_at,
            :updated_at => topic.updated_at,
            :user => User.find_by(id: topic.user_id),
            :type => 'topic'
        }
        @posts.push(tmp)
      end
      @drops.each do |drop|
        tmp = {
            :id => drop.id,
            :content => drop.content,
            :created_at => drop.created_at,
            :updated_at => drop.updated_at,
            :user => User.find_by(id: drop.user_id),
            :type => 'drop'
        }
        @posts.push(tmp)
      end
      @posts = @posts.sort_by { |post| post[:updated_at] }.reverse
      render json: @posts
    end
  end
end
