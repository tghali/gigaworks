# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :glossary_action do |f|
  f.glossary_id 1
  f.user_id 1
  f.target_id 1
  f.target_type "MyString"
  f.action "MyString"
end
