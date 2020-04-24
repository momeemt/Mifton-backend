class User < ApplicationRecord
  has_one :user_job, dependent: :destroy
  has_one :optional_user_datum, dependent: :destroy
  has_many :drops, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :convenience_links, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reports
  has_one_attached :icon
  has_one_attached :header
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { in: 1..15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  VALID_USER_ID_REGEX = /\A[a-zA-Z0-9]+\z/i
  validates :user_id, presence: true, length: { in: 3..15 }, format: { with: VALID_USER_ID_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password
end
