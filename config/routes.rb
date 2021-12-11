Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :books, except: %i(edit new)

      resources :readers, except: %i(edit new)

      resources :borrowings, except: %i(edit new update)

      post '/token', to: 'token#create'

      post '/users', to: 'users#create'
    end
  end
end
