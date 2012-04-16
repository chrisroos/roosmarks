Roosmarks::Application.routes.draw do
  match '/' => redirect('/bookmarks')
  resources :bookmarks, only: [:index, :new, :create]
  resources :tags, only: [:show, :edit, :update]
end
