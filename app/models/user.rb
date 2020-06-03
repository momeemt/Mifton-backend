class User < ApplicationRecord
  has_one :user_job, dependent: :destroy
  has_one :optional_user_datum, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :optional_user_datum, allow_destroy: true
  has_many :drops, dependent: :destroy
  has_many :topics, dependent: :destroy
  # has_many :convenience_links, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reports
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true, length: { in: 1..15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  VALID_USER_ID_REGEX = /\A[a-zA-Z0-9]+\z/i
  validates :user_id, presence: true, length: { in: 3..15 }, format: { with: VALID_USER_ID_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

  has_one_attached :icon_image
  attr_accessor :icon
  attr_accessor :icon_link

  def icon_parse_base64(image)
    if image.present? || rex_image(image) == ''
      content_type = create_extension(image)
      contents = image.sub %r/data:((image|application)\/.{3,}),/, ''
      decoded_data = Base64.decode64(contents)
      filename = Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
      icon_image.detach if icon_image.attached?
      attach_image(filename)
    end
  end

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

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: FILL_IN, reset_sent_at: FILL_IN)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  # 有効化トークン・ダイジェストの作成
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  # base64から拡張子を抽出
  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  # base64から画像のヘッダを抽出
  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end

  # 画像をattachする
  def attach_image(filename)
    icon_image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end
end
