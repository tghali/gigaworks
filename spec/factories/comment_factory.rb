# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :comment do |f|
  f.title ""
  f.user_id 1
  f.commentable_id 1
  f.commentable_type "MyString"
  f.comment "MyText"
end
