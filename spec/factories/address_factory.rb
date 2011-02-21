# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :address do |f|
  f.contact_id 1
  f.first_line "MyString"
  f.second_line "MyString"
  f.state_or_province "MyString"
  f.postcode "MyString"
  f.country "MyString"
  f.type_code 1
end
