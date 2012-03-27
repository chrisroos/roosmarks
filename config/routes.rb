Bookmarks::Application.routes.draw do
  match '/' => redirect('/bookmarks')
  resources :bookmarks, only: [:index, :new, :create]
end
