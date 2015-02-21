Rails.application.routes.draw do

  resources :comps, only: [ :index, :new, :create, :destroy ]
  resources :exports, only: [ :index, :new, :create ]

  root to: 'welcome#index'
end
