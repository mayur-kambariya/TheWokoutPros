class CustomFieldOptionTitle < ApplicationRecord
  ## RelationShip
  belongs_to :user
  has_many :listing, dependent: :destroy
end
