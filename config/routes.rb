Rails.application.routes.draw do

  namespace :admin do
   resources :items, only: [:index, :new, :show, :edit, :create, :update]
   resources :genres, only: [:index, :edit, :create, :update]
   resources :customers, only: [:index, :edit, :show, :update]
   resources :orders, only: [:show, :update]
  end

  devise_for :admins, controller: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }

  get '/admin' => 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
