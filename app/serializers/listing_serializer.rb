class ListingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :valid_until, :open, :origin, :user_id,
              :created_at, :updated_at

  attribute :paln_duration do |listing|
    listing.custom_field_option_title.present? ? listing.custom_field_option_title : ''
  end
  attribute :community_id do |listing|
    listing.community_id.present? ? listing.community_id : ''
  end
  attribute :author_id do |listing|
    listing.author_id.present? ? listing.author_id : ''
  end
  attribute :category do |listing|
    listing.category.present? ? listing.category : ''
  end
  attribute :listing_shape do |listing|
    listing.listing_shape.present? ? listing.listing_shape : ''
  end
  attribute :listing_images do |listing|
    if listing.listing_images.present?
      if listing.listing_images.attached?
        my_listing_images = []
        listing.listing_images.each do |attachment|
          my_listing_images.push(Rails.application.routes.url_helpers.rails_blob_path(attachment, only_path: true))
        end
        my_listing_images
      end
    else
      []
    end
  end
  attribute :location do |listing|
    listing.location.present? ? ListingLocationSerializer.new(listing.location).serializable_hash[:data][:attributes] : {}
  end
end
