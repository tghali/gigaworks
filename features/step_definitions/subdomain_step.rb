require 'uri'

When /^I visit the subdomain "([^"]*)"$/ do |subdomain|
  Capybara.default_host = "#{subdomain}.example.com"
end