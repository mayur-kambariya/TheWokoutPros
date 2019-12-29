class CustomFieldOptionTitle < ApplicationRecord
  ## RelationShip
  belongs_to :user, optional: true
  has_many :listing, dependent: :destroy
end
