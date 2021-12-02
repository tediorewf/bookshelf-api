Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :books, except: %i(edit new)

      resources :readers, except: %i(edit new)

      resources :borrowings, except: %i(edit new)

      get :profile, controller: :profile, action: :show

      post :token, controller: :token, action: :create

      post :users, controller: :users, action: :create
    end
  end
end
