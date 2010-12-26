# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

me = Factory :admin, :user_name => "lpedroni",
                     :contact_attributes => {:first_name => 'Leandro',
                                             :last_name => 'Pedroni',
                                             :email => 'ilpoldo@gmail.com'}


organizations = Array.new(30).map { Factory.populate :organization}
8.times { organizations[rand(organizations.size-1)] = nil}

contacts = Array.new(200).map do
  Factory.populate :contact, :organization => Connie(organizations)
end
