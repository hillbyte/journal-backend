Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :update]
      resources :authentication do
        post :login, on: :collection
      end
      resources :journals do
        resources :entries
      end
      resources :tags
      resources :subscriptions, only: [:create, :index, :show]
      resources :payments, only: [:create, :index, :show]
    end
  end
end
