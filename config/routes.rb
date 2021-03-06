Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  get 'users/my_portfolio'
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: "users#my_portfolio"
  get 'my_friends', to: "users#my_friends"
  get 'search_friend', to: "users#search"
  get 'search_stock', to: "stocks#search"
  resources :friendships, only: [:create, :destroy]
end
