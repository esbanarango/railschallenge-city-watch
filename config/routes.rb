Rails.application.routes.draw do

  namespace :api, path: '', defaults: {format: :json} do
    resources :responders, except: [:edit, :new, :destroy]
  end

end
