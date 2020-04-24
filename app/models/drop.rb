class Drop < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { in: 1..280 }
  validates :user_id, presence: true
end
