# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :lead do |f|
  f.organization {|lead| lead.association(:organization)}
  f.contact      {|lead| lead.association(:contact, :organization => lead.organization)}
  f.status_code 0
  
  f.sales   {|lead| lead.association(:sales)}
  
  # f.source_id  # create a polmorpic source
  
end
