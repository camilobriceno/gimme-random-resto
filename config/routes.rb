Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "up" => "rails/health#show", as: :rails_health_check



  # Defines the root path route ("/")
  # root "posts#index"

  # get "/users/:id", to: "users#show", as: "user"

  # Una ruta GET para / que apunte a searches#index — esta muestra el formulario
  # Una ruta GET para /search que apunte a searches #search — esta procesa la búsqueda

  get "/", controller: "searches", action: :index # or also get "/", to: "searches#index"

  get "/search", controller: "searches", action: :search # or also get "/search", to: "searches#search"

end
