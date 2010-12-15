Given /^I close my browser$/ do
  delete_cookie session_cookie_name
end

Then /^show me the cookies!?$/ do
  driver = Capybara.current_session.driver
  case driver
  when Capybara::Driver::Selenium
    announce_selenium_cookies(Capybara.current_session.driver.browser)
  when Capybara::Driver::RackTest
    announce_rack_test_cookies(get_rack_test_cookie_jar)
  else 
    raise "unsupported driver, use rack::test or selenium/webdriver"
  end
end
