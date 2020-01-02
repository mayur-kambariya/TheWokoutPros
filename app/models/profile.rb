class Profile < ApplicationRecord
	## RelationShip
  belongs_to :user
  has_one_attached :profile_picture
  has_many_attached :aditional_pictures
end
