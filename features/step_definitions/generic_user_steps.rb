Then /^I should be signed in$/ do
  page.driver.request.env['warden'].should be_authenticated
end

Then /^I should not be signed in$/ do
  session.last_request.env['warden'].should_not authenticated
end

Given(/^#{capture_model} (?:has|have) signed up$/) do |name|
  Given "#{name} exists"
end

Given(/^#{capture_model}\s?(?:\'m|am|has|have) signed up as "(\S+)"$/) do |name, user_name|
  Given "#{name} exists with user_name: \"#{user_name}\""
end

Given(/^#{capture_model}\s?(?:\'m|am|has|have)? signed up(?: with #{capture_fields})?$/) do |name, fields|
  attribute_names_for_contact = %w{first_name last_name email telephone}
  
  contact_attributes, user_attributes = parse_fields(fields).partition do |k,v|
    attribute_names_for_contact.include? k
  end.map {|side| Hash[*side.flatten]}
  
  Factory :user, user_attributes.merge({:contact => Factory(:user_contact, contact_attributes)})
end

When(/^I sign in as "(\S+)"$/) do |user_name|
  When "I go to the sign in page"
  fill_in 'User name or email', :with => user_name 
  fill_in 'Password', :with => "big secret"
  click_button 'Sign in'
end


When(/^I sign in with "(\S+)", "(.*)"$/) do |user_name, password|
  When "I go to the sign in page"
  fill_in 'User name or email', :with => user_name
  fill_in 'Password', :with => password
  click_button 'Sign In'
end

Given %r{#{capture_model}\s?(?:'m|is|am) signed in(?: with #{capture_fields})?$} do |name, fields|
  @user = find_model(name) || create_model(name, fields)
  visit "/sign_in"
  fill_in 'User name or email', :with => @user.user_name 
  fill_in 'Password', :with => 'big secret'
  click_button 'Sign In'
end


Given %r{I(?:'m|\sam) signed in as #{capture_model}(?: with #{capture_fields})?$} do |name, fields|
  @user = find_model(name) || create_model(name, fields)
  visit "/sign_in"
  fill_in 'User name or email', :with => @user.user_name
  fill_in 'Password', :with => 'big secret'
  click_button 'Sign In'
end

# Current user model tools, mutuated from pickle

# assert model is in another model's has_many assoc
Then(/^my user should be (?:in|one of|amongst) #{capture_model}'s (\w+)$/) do |owner, association|
  model(owner).send(association).should include(current_user)
end

# assert model is not in another model's has_many assoc
Then(/^my user should should not be (?:in|one of|amongst) #{capture_model}'s (\w+)$/) do |owner, association|
  model(owner).send(association).should_not include(current_user)
end

# assert model is another model's has_one/belongs_to assoc
Then(/^my user should be #{capture_model}'s (\w+)$/) do |owner, association|
  model(owner).send(association).should == current_user
end

# assert model is not another model's has_one/belongs_to assoc
Then(/^my user should not be #{capture_model}'s (\w+)$/) do |owner, association|
  model(owner).send(association).should_not == current_user
end

# assert model.predicate? 
Then(/^my user should (?:be|have) (?:an? )?#{capture_predicate}$/) do |name, predicate|
  current_user.user.should send("be_#{predicate.gsub(' ', '_')}")
end

# assert not model.predicate?
Then(/^my user should not (?:be|have) (?:an? )?#{capture_predicate}$/) do |name, predicate|
  current_user.user.should_not send("be_#{predicate.gsub(' ', '_')}")
end