class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :user_id, :password_digest
  has_many :drops
end
