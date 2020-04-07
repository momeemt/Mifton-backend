class ConvenienceLinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :link, :is_public
end
