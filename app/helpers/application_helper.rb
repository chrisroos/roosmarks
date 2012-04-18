module ApplicationHelper
  def twitter_bootstrap_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(record_or_name_or_array, *(args << options.merge(:builder => TwitterBootstrapFormBuilder)), &proc)
  end

  def markdown_to_html(markdown)
    return "" unless markdown
    engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    engine.render(markdown).html_safe
  end
end
