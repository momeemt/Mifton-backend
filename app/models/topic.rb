class Topic < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 1..30 }
  validates :content, presence: true, length: { minimum: 140 }
  validates :user_id, presence: true
end
