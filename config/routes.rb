Rails.application.routes.draw do
  devise_for :users
  resources :events do
    resources :recaps
  end
  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :locations
  get 'manage' => "manage#index"
end
