Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  resources :chats, only: [:index, :show, :create]
  root :to => 'home#index'
  mount Commontator::Engine => '/commontator'
end
