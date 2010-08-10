# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.name "MyString"
  f.hashed_password "MyString"
  f.salt "MyString"
  f.contact_id 1
  f.status_code 1
  f.roles_mask 1
  f.avatar_file_name "MyString"
  f.avatar_content_type "MyString"
  f.avatar_file_size 1
  f.avatar_uploaded_at "2010-08-09 15:26:41"
end
