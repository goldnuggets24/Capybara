Rails.application.routes.draw do
  match '/pictures/top-ten' => 'pictures#index', :as => 'top-ten', :via => [:get]
  resources :pictures do
    get 'score', :on => :member
    get 'search', :on => :collection
    get 'home', :on => :collection
  end

  root 'pictures#home'
end
