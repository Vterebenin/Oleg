Rails.application.routes.draw do
	resources :olegs
	root "olegs#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
