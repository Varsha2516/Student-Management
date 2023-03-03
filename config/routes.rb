Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  


  # resources :sessions, only: [:create]
  resources :users, only: [:create]
  get "login"=> "users#login"
  post "forgot_password"=> "users#forgot_password"
  post "reset_password"=> "users#reset_password"
  post "logout" => "users#logout"


  resources :students, only: [:index, :show, :create, :update, :destroy]
  get "mark_list"=> "students#mark_list"
  

  resources :marks, only: [:index, :create, :update, :destroy]
  get "students/:id/marks"=> "marks#show"
  get "query"=> "marks#query"
  



  


end