Rails.application.routes.draw do
  get '/flats/list', to: 'flats#list'
  devise_for :users
  root to: 'pages#home'

  resources :flats, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
