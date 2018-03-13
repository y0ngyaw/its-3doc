Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  
  resources :participants 
  resources :proposals
  resources :pendings, only: [:create, :destroy]
  resources :team_members, only: [:create, :destroy] do 
    member do 
      post :leave
      post :acknowledge
      post :stay
    end 
  end 

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
