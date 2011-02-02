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
  
  def account_links
    if user = current_user
      profile = link_to current_user.email, account_path
      sign_out = link_to t(:'account.Signout'), sign_out_path
      
      "#{profile} <span>(#{sign_out})</span>"
    else
      link_to(t(:'account.Signin'), sign_in_path)+'&nbsp;|&nbsp;'+link_to(t(:'account.Signup'), '/sign_up')
    end
  end
  
  def list_item_highlighted_if_match one, two
    args = [:li]
    args << {:class => 'selected'} if one == two
    
    open *args do
      yield
    end
  end
  
end
