Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  root "recipes#index"
  resources :recipes, except: [:edit, :update] do
    resources :recipe_foods, only: [:index, :new, :create, :destroy]
  end

  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
  get '/general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'

  # Defines the root path route ("/")
  # root "posts#index"
end
