# this is the categories controller
class Api::V1::CategoriesController < ApiController

  def index
    listing_category = Category.all
    if listing_category.present?
      get_listing_category = CategorySerializer.new(listing_category).serializable_hash[:data].map{ |data| data[:attributes]}
      success_response_with_object(get_listing_category,
        "Ok")
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t("#{get_controller}.index.category_not_found")
      )
    end
  end
end
