# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.user_name "lpedroni"
  f.contact {|u| u.association(:user_contact, :email => "#{u.user_name}@example.com") }
  f.password 'big secret'
  f.password_confirmation  'big secret'
  f.status :verified
end

Factory.define :user_contact, :class => Contact do |f|
  f.first_name "Leandro"
  f.last_name "Pedroni"
  f.email {|c| "#{c.first_name}_#{c.last_name}@example.com".downcase.gsub(" ","_")}
end