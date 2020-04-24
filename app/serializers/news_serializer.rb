class NewsSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
end
