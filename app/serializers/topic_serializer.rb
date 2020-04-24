class TopicSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :user_id, :created_at, :updated_at
  belongs_to user
end
