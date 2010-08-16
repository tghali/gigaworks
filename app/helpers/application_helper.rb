module ApplicationHelper

  def title page_title
    page_title += ' - '
    content_for(:title) {page_title}
  end

  def meta names_and_contents
    buffer = (content_for?(:meta) ? @content_for_meta.to_s : '')
    
    names_and_contents.map do |name, content|
      buffer << %Q{<meta name="#{name}" content="#{content}">\n}.html_safe
    end
    
    content_for(:meta) do
      buffer.html_safe
    end
  end
  
end
