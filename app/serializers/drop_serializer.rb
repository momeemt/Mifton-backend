class DropSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :created_at, :updated_at
end
