class AuthToken < ApplicationRecord
  ## RelationShip
  belongs_to :user

  ## Validation
  validates :auth_token, uniqueness: true
end
