Rails.application.routes.draw do

  resources :comps, only: [ :index, :new, :create, :destroy ]
  resources :exports, only: [ :index, :new, :create ]

  get '/admin', to: redirect('/admin/framesets')
  namespace :admin do
    resources :framesets
    resources :frames
  end

  root to: 'welcome#index'
end
