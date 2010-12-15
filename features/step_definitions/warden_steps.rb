# Given /^I am signed in(?: as "([^"]*)")?$/ do |user_name|
#   if user_name
#     login_as (User.find_by_user_name(user_name) || Factory(:user, :user_name => user_name))
#   else
#     login_as Factory :user
#   end
# end
# 
# When /^I sign out$/ do |user_name|
#   logout
# end