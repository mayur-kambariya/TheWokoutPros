class Location < ApplicationRecord
  ## RelationShip
  belongs_to :listing
  belongs_to :community, optional: true
end
