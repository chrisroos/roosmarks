embedly_api = Embedly::API.new key: 'cd766a9353ba426dbc33103083b5b68c'

Bookmark.all.each do |bookmark|
  next unless bookmark.url =~ /imgur\.com/
  next if bookmark.image_url.present?

  embedly_object = embedly_api.oembed url: bookmark.url, maxwidth: 500
  bookmark.image_url = embedly_object.first.url
  bookmark.save!
  # => [#<Embedly::EmbedlyObject provider_url="http://imgur.com", version="1.0", thumbnail_width=90, height=410, width=550, thumbnail_url="http://imgur.com/Y2U1JJ3s.jpg", url="http://imgur.com/Y2U1JJ3.jpg", provider_name="Imgur", type="photo", thumbnail_height=90>]
  
end
# 