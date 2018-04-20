Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'sessions#new'

  scope '/hackathon' do 
    root 'sessions#new'
    resources :participants 
    resources :proposals do 
      member do 
        post :top5
      end 
    end
    resources :pendings, only: [:create, :destroy]
    resources :team_members, only: [:create, :destroy] do 
      member do 
        post :leave
        post :acknowledge
        post :stay
      end 
    end 
    resources :votes, only: [:new, :create, :index] do 
      collection do 
        get :results
        get :general_results
        get :sponsor_results
        get :votes_redirect
        get :get_general_result
        get :get_sponsor_result
      end  
    end 
    resources :sponsor_votes, only: [:new, :create]

    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  scope '/sponsor' do 
    resources :sponsors, only: [:new, :create, :index, :destroy]
    resources :projects

    get '/login', to: 'sponsor_sessions#new', as: 'sponsor_login'
    post '/login', to: 'sponsor_sessions#create'
    delete '/logout', to: 'sponsor_sessions#destroy', as: 'sponsor_logout'
  end

end
