class OptionalUserDatum < ApplicationRecord
  belongs_to :user, inverse_of: :optional_user_datum
end
