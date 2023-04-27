Rails.application.routes.draw do
  resources :employees
  resources :payments

  post '/folha/cadastrar', to: 'payments#create'
  get '/folha/calcular', to: 'payments#calculate'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
