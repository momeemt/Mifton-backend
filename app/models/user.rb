class User < ApplicationRecord
  has_one :user_job
  has_many :drops
  has_many :convenience_links
  has_one_attached :icon
  has_one_attached :header
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { in: 1..15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  VALID_USER_ID_REGEX = /\A[a-zA-Z0-9]+\z/i
  validates :user_id, presence: true, length: { in: 3..15 }, format: { with: VALID_USER_ID_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
