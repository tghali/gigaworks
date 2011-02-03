# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :translation_rating do |f|
  f.translation_id 1
  f.translator_id 1
  f.vote 1
  f.note "MyString"
end
