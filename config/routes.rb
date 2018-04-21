Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/friends', to: 'users#myFriends'
  post '/connect', to: 'users#connectToFriend'
  post '/common_friends', to: 'users#commonFriends'
  post '/subscribe', to: 'users#subscribe'
  post '/block', to: 'users#blockFriend'
  post '/send_email', to: 'users#sendEmail'
end
