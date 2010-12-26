Given /^a (\w*) account(?: with #{capture_fields})? is authorized$/ do |provider, fields|
  case provider
  when 'facebook'
    credentials = {'name'=>'John Smith',
                   'location'=>{'name'=>'London, United Kingdom', 'id'=>'106078429431815'},
                   'id'=>'718831364',
                   'timezone'=>1,
                   'last_name'=>'Smith',
                   'link'=>'http://www.facebook.com/profile.php?id=123456789',
                   'hometown'=>{'name'=>'London, United Kingdom', 'id'=>'106078429431815'},
                   'locale'=>'en_US',
                   'verified'=>true,
                   'updated_time'=>'2010-11-19T02:35:31+0000',
                   'email'=>'johns.smith@example.com',
                   'first_name'=>'John'}
  else
    credentials = {}
  end
  
  Fredo.oauth(provider, credentials.merge(parse_fields fields))
end

Then /^show me the books$/ do
  raise Fredo.books.to_yaml
end