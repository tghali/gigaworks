# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :contact do |f|
  # Connie[:names].first_with_title
  f.title         {Connie(:names).title}
  f.first_name    {Connie(:names).first}
  f.last_name     {Connie(:names).last}
  f.organization  {|contact| contact.association(:organization)}
  f.timezone_code {Connie ['GMT', 'PST', 'EST']}
  f.email         {|c| "#{c.first_name}.#{c.last_name}@example.com"}
  f.telephone     {Connie(:numbers).international_telephone}
end
