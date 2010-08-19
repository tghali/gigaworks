# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user_verification_key do |f|
  f.user_id 1
  f.token "MyString"
  f.request_ip "MyString"
  f.sent_at "2010-08-19 12:13:30"
  f.password_reset false
end
