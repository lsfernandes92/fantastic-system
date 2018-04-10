Rails.application.routes.draw do
  resources :todo_lists
  get 'welcome/index'
  resources :todo_lists  
  root 'welcome#index'
end
