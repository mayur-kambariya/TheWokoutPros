# This is the invitations model
class Invitation < ApplicationRecord
	## RelationShip
  belongs_to :user

  ## Validation
  validates :email, presence: true
end
