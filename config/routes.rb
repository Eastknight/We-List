Rails.application.routes.draw do
  devise_for :users, 
             :controllers => {:sessions => "my_devise/sessions", :registrations => "my_devise/registrations"}

  root to: 'welcome#index'

  resources :lists, except: [:new] do
    resources :items, only: [:create, :destroy]
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :lists, only: [:index, :show, :update, :destroy, :create] do
        resources :items, only: [:index, :create] 
      end
      get 'lists/:id/preview', to: 'lists#preview'
      resources :items, only: [:show, :update, :destroy]
    end
  end

end
