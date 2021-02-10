Rails.application.routes.draw do

  scope module: :public do

    resources :items, only: [:index, :show]

    resources :customer, only: [:show, :edit, :update] do
      collection do
        get 'quit'
        patch 'out'
      end
    end

    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'all_destroy'
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      member do
        get 'confirmation'
        post 'confirm'
      end
      collection do
        get 'thanks'
      end
    end
  end

  root 'public/homes#top'
  get '/about' => 'public/homes#about'

  namespace :admin do
   resources :items, only: [:index, :new, :show, :edit, :create, :update]
   resources :genres, only: [:index, :edit, :create, :update]
   resources :customers, only: [:index, :edit, :show, :update]
   resources :orders, only: [:show, :update]
  end

  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    passwords: 'customers/passwords'
  }

  get '/admin' => 'admin/homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
