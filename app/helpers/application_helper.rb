module ApplicationHelper
  def markdown_to_html(markdown)
    return "" unless markdown
    engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    engine.render(markdown).html_safe
  end
end
