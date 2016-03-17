Rails.application.routes.draw do
  resources :pictures do
    get 'score', :on => :member
    get 'search', :on => :collection
    get 'home', :on => :collection
  end

  root 'pictures#home'
end
