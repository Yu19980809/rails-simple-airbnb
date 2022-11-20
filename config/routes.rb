Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :flats, except: [:destroy]
  delete 'flats/:id', to: 'flats#destroy', as: :destroy_flat
end
