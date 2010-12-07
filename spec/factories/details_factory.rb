# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :detail do |f|
  f.contact_id 1
  f.property_code 1
  f.value "MyString"
  f.type_mask 1
  f.extra_property_code 1
  f.extra_property_value "MyString"
end
