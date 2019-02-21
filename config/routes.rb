Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/new'
  get 'bookings/create'
  get '/flats/list', to: 'flats#list'
  devise_for :users
  root to: 'pages#home'

  resources :flats, only: [:index, :new, :create] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
