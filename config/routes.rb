ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
end
