Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :messages, only: [:index, :create, :destroy, :show]
    end
  end

  get '*path', to: 'pages#index', via: :all
end
