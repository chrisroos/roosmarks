Roosmarks::Application.routes.draw do
  match '/' => redirect('/bookmarks')
  resources :bookmarks, only: [:index, :new, :create, :edit, :update]
  resources :tags, only: [:show, :edit, :update]
end
