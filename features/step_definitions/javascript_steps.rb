When /^(?:|I )follow and confirm "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|

  page.evaluate_script("my_message = '';
    window.confirm = function (msg) {
      my_message = msg;
      return true;
    }")
  
  with_scope(selector) do
    click_link(link)
  end
end
