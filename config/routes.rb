Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users
      post '/users/sign_up', to: 'registrations#create'
      post '/users/confirm', to: 'confirmations#create'
      post '/users/forget_password', to: 'passwords#create'
      post '/users/change_password', to: 'passwords#change_password'
      patch '/users/reset_password', to: 'passwords#reset_password'
      resources :categories, only: :index
      resources :listing_shapes , only: :index
      resources :custom_field_option_titles, only: :index
      resources :listings
      get '/get_user_listings', to: 'listings#get_user_listings'
      resources :invitations, only: :create
      resources :profiles, only: [:update, :show]
    end
  end
end
