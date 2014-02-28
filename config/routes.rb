Roosmarks::Application.routes.draw do
  get '/' => redirect('/bookmarks')
  resources :bookmarks, only: [:index, :new, :create, :edit, :update]
  get '/bookmarks/:url', to: 'bookmarks#show', constraints: {url: /.+/}
  resources :tags, only: [:show, :edit, :update]
end
