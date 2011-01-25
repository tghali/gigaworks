# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

gigavine = Factory :organisation, :name => 'Gigavine', :country_code => :uk

me = Factory :admin, :user_name => "lpedroni",
                     :contact => Factory(:user_contact, :first_name => 'Leandro',
                                                        :last_name  => 'Pedroni',
                                                        :organisation => gigavine,
                                                        :email      => 'ilpoldo@gmail.com')


organisations = Array.new(30).map { Factory.populate :organisation}
8.times { organisations[rand(organisations.size-1)] = nil}

contacts = Array.new(200).map do
  Factory.populate :contact, :organisation => Connie(organisations)
end
