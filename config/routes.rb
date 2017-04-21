Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels, only: [:show, :new, :create] do
    resources :messages, only: [:create, :destroy]
  end

  delete 'delete-selected-user/:id', to: "channels#delete_selected_user", as: "delete_selected_user"
end
