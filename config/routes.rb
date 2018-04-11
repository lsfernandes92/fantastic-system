Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists do
    resources :todo_items
  end
  authenticated :user do
    root "todo_lists#index", as: "authenticated_user"
  end
  root "welcome#index"
end
