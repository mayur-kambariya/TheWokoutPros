class ListingLocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :latitude, :longitude, :address, :google_address,
             :listing_id, :location_type, :community_id, :_destroy
end
