Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists do
    resources :todo_items do
      patch :complete, on: :member
    end
  end
  authenticated :user do
    root "todo_lists#index", as: "authenticated_user"
  end
  root "welcome#index"
end
