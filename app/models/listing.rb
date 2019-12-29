class Listing < ApplicationRecord
  ## RelationShip
  belongs_to :user
  belongs_to :custom_field_option_title
  belongs_to :category
  belongs_to :listing_shape
  has_one :location, dependent: :destroy
  accepts_nested_attributes_for :location
  has_many_attached :listing_images


   ## Validation
   validates :custom_field_option_title, :title, :price, presence: true
end
