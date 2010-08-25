# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.user_name "lpedroni"
  f.email {|user| "#{user.user_name}@example.com".downcase.gsub(" ","_")}
  f.password 'big secret'
  f.password_confirmation  'big secret'
  f.status :verified
end
