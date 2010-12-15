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

Factory.define :user_contact, :class => Contact do |f|
  def f.full_name &block
    title, first, last = block.call
    self.first_name first
    self.last_name  last
    self.title      title
  end
  
  f.full_name {(Connie(:names).first_with_title << Connie(:names).last)}
  
  f.email {|c| "#{c.first_name}_#{c.last_name}@example.com".downcase.gsub(" ","_")}
end