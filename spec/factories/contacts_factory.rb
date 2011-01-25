# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :contact do |f|  
  f.first_with_title {Connie(:names).first_sometimes_with_title}
  f.last_name        {Connie(:names).last}
  f.organisation     {|contact| Connie? ? contact.association(:organisation) : nil}
  f.timezone_code    {Connie ['GMT', 'PST', 'EST']}
  f.email            {|c| "#{c.first_name}.#{c.last_name}@example.com"}
  f.telephone        {Connie(:numbers).international_telephone}
                     
  f.details          { |contact| Array.new(rand 3).map {contact.association :detail} }
end

Factory.define :user_contact, :class => Contact do |f|
  f.first_name {Connie(:names).first}
  f.last_name  {Connie(:names).last}
  
  f.email {|c| "#{c.first_name}_#{c.last_name}@example.com".downcase.gsub(" ","_")}
end