Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  get "/", to: "user#index"
  get "/user/:id", to: "user#show_user", as: "show_user"
  get "/user/:id/posts", to: "user#show_user_posts"
  get "/user/:id/posts/:post_id", to: "user#show_user_specific_post", as: "show_user_specific_post"
  post "/user/new", to: "user#create"
  put "/user/update/:id", to: "user#update"
  delete "/user/delete/:id", to: "user#delete"

  get "/sign_in", to: "sessions#sign_in"
  delete "/log_out", to: "sessions#log_out"

  # Defines the root path route ("/")
  root "user#index"
end
