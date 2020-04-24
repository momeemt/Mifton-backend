class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :user_id, :password_digest, :created_at
  has_many :drops
  has_many :notifications
  has_one :user_job
  has_one :optional_user_datum
end
