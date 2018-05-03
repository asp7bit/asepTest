Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/friends', to: 'users#myFriends', as: :friends
  post '/connect', to: 'users#connectToFriend', as: :connect
  post '/common_friends', to: 'users#commonFriends', as: :common_friends
  post '/subscribe', to: 'users#subscribe', as: :subscribe
  post '/block', to: 'users#blockFriend', as: :block
  post '/send_email', to: 'users#sendEmail', as: :send_email
end
