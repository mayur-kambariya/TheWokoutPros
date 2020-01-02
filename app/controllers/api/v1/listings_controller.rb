class Api::V1::ListingsController < ApiController
  before_action :find_listing, only: [:show, :update, :destroy]

  def index
    all_listings = Listing.all
    get_listing(all_listings)
  end

  def get_user_listings
    user_listing = current_user.listings
    get_listing(user_listing)
  end

  def create
    listing = current_user.listings.new(listing_params)
    if listing.save
      if params[:listing][:listing_images].present?
        listing.listing_images.attach(params[:listing][:listing_images])
      end
      listing_info = ListingSerializer.new(listing).serializable_hash[:data][:attributes]
      success_response_with_message(
        listing_info,
        I18n.t("#{get_controller}.create.listing_created")
      )
    else
      error_response_without_obj(HTTP_BAD_REQUEST, listing.errors.full_messages.join(', '))
    end
  end

  def show
    listing_info = ListingSerializer.new(@listing)
    success_response_with_object(listing_info.serializable_hash[:data][:attributes],
      "Ok")
  end

  def update
    if @listing.update(listing_params)
      if params[:listing][:listing_images].present?
        @listing.listing_images.attach(params[:listing][:listing_images])
      end
      my_listing_info = ListingSerializer.new(@listing).serializable_hash[:data][:attributes]
      success_response_with_message(
        my_listing_info,
        I18n.t("#{get_controller}.update.update_success")
      )
    else
      error_response_without_obj(
        HTTP_BAD_REQUEST,
        @listing.errors.full_messages.join(', ')
      )
    end
  end

  def destroy
    if @listing.destroy
      success_response(HTTP_OK, I18n.t("#{get_controller}.destroy.destroy_success"))
    else
      error_response_without_obj(
        HTTP_BAD_REQUEST,
        @listing.errors.full_messages.join(', ')
      )
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :valid_until, :open,
      :origin, :price, :user_id, :custom_field_option_title_id,
      :community_id, :author_id, :category_id, :listing_shape_id,
      location_attributes: [
        :id, :latitude, :longitude, :address, :google_address,
        :listing_id, :location_type, :community_id, :_destroy
      ]
    )
  end

  def find_listing
    @listing = Listing.find_by(id: params[:id])
    unless @listing.present?
      error_response_without_obj(
        HTTP_BAD_REQUEST,
        I18n.t("#{get_controller}.show.listing_not_found")
      )
    end
  end

  def get_listing(my_listings)
    if my_listings.present?
      get_listing = ListingSerializer.new(my_listings).serializable_hash[:data].map{ |data| data[:attributes]}
      success_response_with_object(get_listing,
        "Ok")
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t("#{get_controller}.index.listing_not_found")
      )
    end
  end
end
