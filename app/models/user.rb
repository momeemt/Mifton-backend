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

  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true, length: { in: 1..15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  VALID_USER_ID_REGEX = /\A[a-zA-Z0-9]+\z/i
  validates :user_id, presence: true, length: { in: 3..15 }, format: { with: VALID_USER_ID_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  # 有効化トークン・ダイジェストの作成
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = user.digest(activation_token)
  end
end
