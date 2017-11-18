Rails.application.routes.draw do
  resources :event_recaps
  devise_for :users
  resources :events do
    resources :event_recaps
  end
  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :locations

end
