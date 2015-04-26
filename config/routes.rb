Rails.application.routes.draw do
  match 'responders/new', to: 'application#routing_error', via: :all
  match 'emergencies/new', to: 'application#routing_error', via: :all
  namespace :api, path: '', defaults: { format: :json } do
    resources :responders, param: :name, except: [:edit, :new, :destroy]
    resources :emergencies, param: :code, except: [:edit, :new, :destroy]
  end
  match '*path', to: 'application#routing_error', via: :all
end
