# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :invite do |f|
  f.recipient {|u| u.association(:user_contact) }
  f.sent_at {Time.now}
end
