Rails.application.routes.draw do

  get '/admin', to: redirect('/admin/framesets')
  namespace :admin do
    resources :framesets do
      resources :frames
    end
  end

  resources :comps, only: [ :index, :new, :create, :destroy ]
  resources :exports, only: [ :index, :new, :create, :edit, :update ]
  resources :framesets, only: [ :index ]

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root to: 'welcome#index'
end
