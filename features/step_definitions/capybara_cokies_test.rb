Then /^I should have working cookies$/ do
  driver.visit('/sign_in')
  driver.body.should_not include('test_cookie')
  
  driver.visit('/cookie')
  driver.body.should include('Cookie set to test_cookie')
  
  driver.visit('/get_cookie')
  driver.body.should include('test_cookie')
  
  driver.reset!
  driver.visit('/get_cookie')
  driver.body.should_not include('test_cookie')
end