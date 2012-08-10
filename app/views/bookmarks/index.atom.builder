atom_feed do |feed|
  feed.title "All bookmarks"
  feed.updated @bookmarks.last.created_at
  feed.author do |author|
    author.name USERNAME
  end

  @bookmarks.each do |bookmark|
    feed.entry(bookmark, url: bookmark.url) do |entry|
      entry.title bookmark.title
      content = bookmark.comments.present? ? markdown_to_html(bookmark.comments) : bookmark.title
      entry.content content, type: 'html'
    end
  end
end