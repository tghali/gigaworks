module CookieStepHelper
  def session_cookie_name
    Rails.application.config.session_options[:key]
  end

  def delete_cookie(cookie_name)
    driver = Capybara.current_session.driver
    case driver
    when Capybara::Driver::Selenium
      browser = Capybara.current_session.driver.browser
      announce_selenium_cookies(browser) if @announce
      browser.manage.delete_cookie(cookie_name)
      announce "Deleted cookie: #{cookie_name}" if @announce
      announce_selenium_cookies(browser) if @announce
    when Capybara::Driver::RackTest
      announce_rack_test_cookies(get_rack_test_cookie_jar) if @announce
      delete_rack_test_cookie(get_rack_test_cookie_jar, cookie_name)
      announce "Deleted cookie: #{cookie_name}" if @announce
      announce_rack_test_cookies(get_rack_test_cookie_jar) if @announce
    else 
      raise "unsupported driver, use rack::test or selenium/webdriver"
    end
  end

  def announce_rack_test_cookies(cookie_jar)
    announce "Current cookies: #{ERB::Util.html_escape(cookie_jar.instance_variable_get(:@cookies).inspect)}"
  end
  
  def announce_selenium_cookies(browser)
    announce "Current cookies: #{ERB::Util.html_escape(browser.manage.all_cookies.map(&:inspect).join(", "))}"
  end
  
  def get_rack_test_cookie_jar
    rack_test_driver = Capybara.current_session.driver
    cookie_jar = rack_test_driver.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
  end
  
  def delete_rack_test_cookie(cookie_jar, cookie_name)
    cookie_jar.instance_variable_get(:@cookies).reject! do |existing_cookie|
      existing_cookie.name.downcase == cookie_name
    end
  end
end

World(CookieStepHelper)
Before('@announce') do
  @announce = true
end