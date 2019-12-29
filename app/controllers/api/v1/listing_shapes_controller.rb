# this is the listing shapes controller
class Api::V1::ListingShapesController < ApiController
  def index
    listing_shapes = ListingShape.all
    if listing_shapes.present?
      get_listing_shapes = ListingShapeSerializer.new(listing_shapes).serializable_hash[:data].map{ |data| data[:attributes]}
      success_response_with_object(get_listing_shapes,
        "Ok")
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t("#{get_controller}.index.listing_shape_not_found")
      )
    end
  end
end
