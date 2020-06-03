class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :user_id, :password_digest, :created_at, :icon_link
  has_many :notifications
  has_one :user_job
  has_one :optional_user_datum
    # attribute :optional_user_datum, key: :optional_user_data_attributes
end
