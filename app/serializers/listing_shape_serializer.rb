class ListingShapeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :community_id, :name
end
