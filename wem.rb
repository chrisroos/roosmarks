Bookmark.all.each do |bookmark|
  u = URI.parse(bookmark.url)
  bookmark.favicon_url = "#{u.scheme}://#{u.host}/favicon.ico"
  bookmark.save!
  # bookmark.favicon_url = 
end
