Then /^the response status should be (\d+)$/ do |code|
  page.driver.response.status.should eql(code.to_i)
end

Then /^the response header should have ([\w\-_]+)(?: set to "([^"]*)")?$/ do |param, value|
  header = page.driver.response.headers
  header.should have_key param
  header[param].should eql(value) if value
end