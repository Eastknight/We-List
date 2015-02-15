Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  get 'welcome/about'

  root to: 'welcome#index'

  resources :lists, except: [:index] do
    resources :items, only: [:create, :destroy]
  end

end
