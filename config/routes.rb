Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :driver, only: [:create] do
        collection do
          post :register
        end
          post :sendLocation
      end
    end
  end
end
