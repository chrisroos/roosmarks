Roosmarks::Application.routes.draw do
  match '/' => redirect('/bookmarks')
  resources :bookmarks, only: [:index, :new, :create, :edit, :update]
  match '/bookmarks/:url', to: 'bookmarks#show', constraints: {url: /.+/}
  resources :tags, only: [:show, :edit, :update]
end
