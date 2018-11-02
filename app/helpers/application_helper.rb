module ApplicationHelper
  
  def load_markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def markdown_render(text)
    load_markdown
    @markdown.render(text).html_safe
  end
end
