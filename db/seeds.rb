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



Factory :word, :language => :en, :word => 'hello', :definitions => [
  Factory(:definition, :kind => :exclamation, :description => 'Common form of greeting',
          :translated_words => [Factory(:word, :language => :fr, :word => 'bonjour'),
                                Factory(:word, :language => :it, :word => 'ciao'),
                                Factory(:word, :language => :es, :word => 'hola')]
          )
]


s = Sentence.create(:language => :en, :text => 'hello world',)
s.update_attributes :translations_attributes => {
                      "0" => {:language => :it, :text => 'ciao mondo'},
                      "1" => {:language => :fr, :text => 'bonjour monde'},
                      "2" => {:language => :ar, :text => 'مرحبا للعالم'}
                      }