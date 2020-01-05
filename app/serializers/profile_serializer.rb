class ProfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :display_name, :location, :about_you,
  					 :created_at, :updated_at

	attribute :user_id do |profile|
    profile.user_id.present? ? profile.user_id : ''
  end
  attribute :user_email do |profile|
    profile.user.present? ? profile.user.email : ''
  end
  attribute :profile_picture do |profile|
    if profile.profile_picture.present?
      '' #Rails.application.routes.url_helpers.rails_blob_path(profile.profile_picture, only_path: true)
    else
      ''
    end
  end
  attribute :aditional_pictures do |profile|
    if false && profile.aditional_pictures.present?
      if profile.aditional_pictures.attached?
        my_aditional_pictures = []
        profile.aditional_pictures.each do |attachment|
          my_aditional_pictures.push(Rails.application.routes.url_helpers.rails_blob_path(attachment, only_path: true))
        end
        my_aditional_pictures
      end
    else
      []
    end
  end
end