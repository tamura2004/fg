Rails.application.routes.draw do
  root "sessions#new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :zones do
  	resources :contents
	get "login" => "sessions#new", as: :login
	post "session" => "sessions#create", as: :session
	delete "session" => "sessions#destroy"
  end

end
