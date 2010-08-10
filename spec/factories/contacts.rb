# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :contact do |f|
  f.first_name "MyString"
  f.last_name "MyString"
  f.organization_id 1
  f.title "MyString"
  f.timezone_code 1
  f.email "MyString"
  f.telephone "MyString"
end
