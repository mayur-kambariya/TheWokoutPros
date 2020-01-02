class Feedback < ApplicationRecord
	## RelationShip
  belongs_to :user

  ## Validation
  validates :content, presence: true
end
