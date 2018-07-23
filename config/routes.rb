Rails.application.routes.draw do
  root 'chat_rooms#index'
  get 'chat_rooms/index'
  get 'chat_rooms/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
