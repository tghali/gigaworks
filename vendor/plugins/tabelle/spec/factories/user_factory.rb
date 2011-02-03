Factory.define :user do |u|
  u.user_name {Factory.next(:user_name)}
  u.email {|user| "#{user.user_name}@example.com".downcase.gsub(" ","_")}
  u.password 'big secret'
  u.password_confirmation 'big secret'
  u.first_name {Factory.next(:first_name)}
  u.status %(unverified verified suspended deleted)[rand(4)]
end

Factory.sequence :user_name do |n|
  names = %w(paul matt baldrick mario tony)
  
  names[n%names.size]+" #{n/names.size}"
end

Factory.sequence :first_name do |n|
  names = %w(Paul Matt Baldrick Mario Tony)
  
  names[n%names.size]
end