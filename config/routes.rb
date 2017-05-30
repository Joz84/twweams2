Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :subscriptions, only: [:create, :destroy]
    resources :messages, only: [:create, :destroy]
  end

  get 'first-connection', to: "channels#first_connection"
  delete 'delete-selected-user/:id', to: "channels#delete_selected_user", as: "delete_selected_user"

  mount ActionCable.server => '/cable'
end
