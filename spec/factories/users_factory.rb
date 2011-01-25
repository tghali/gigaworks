# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|  
  f.contact {|u| u.association(:user_contact) }
  f.user_name {|u| "#{u.contact.first_name.first}#{u.contact.last_name}"}
  f.password               'big secret'
  f.password_confirmation  'big secret'
  f.status :verified
end

Factory.define :admin, :class => User do |f|  
  f.contact {|u| u.association(:user_contact) }
  f.user_name {|u| "#{u.contact.first_name.first}#{u.contact.last_name}"}
  f.password               'big secret'
  f.password_confirmation  'big secret'
  f.roles [:admin]
  f.status :verified
end