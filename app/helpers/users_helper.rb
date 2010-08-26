module UsersHelper
  
  def user_slug
    contact = current_user.contact
    name = "#{contact.first_name} #{contact.last_name}"
    user_name = content_tag(:span, current_user.user_name)
    "#{name} (#{user_name})".html_safe
  end
  
end
