class ListingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :valid_until, :open, :origin, :user_id

  attribute :custom_field_option_title_id do |listing|
    listing.custom_field_option_title_id.present? ? listing.custom_field_option_title_id : ''
  end
  attribute :community_id do |listing|
    listing.community_id.present? ? listing.community_id : ''
  end
  attribute :author_id do |listing|
    listing.author_id.present? ? listing.author_id : ''
  end
  attribute :category_id do |listing|
    listing.category_id.present? ? listing.category_id : ''
  end
  attribute :listing_shape_id do |listing|
    listing.listing_shape_id.present? ? listing.listing_shape_id : ''
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
    listing.location.present? ? listing.location : {}
  end
end
