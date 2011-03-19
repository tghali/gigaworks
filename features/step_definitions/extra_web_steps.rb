Then /^(?:|I )should see a "([^"]*)" link(?: within "([^"]*)")?$/ do |text|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath('//a', :text => text)
    else
      assert page.has_xpath?('//a', :text => text)
    end
  end
end

Then /^(?:|I )should not see a "([^"]*)" link(?: within "([^"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_xpath('//a', :text => text)
    else
      assert page.has_no_xpath?('//a', :text => text)
    end
  end
end
