# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :lead do |f|
  f.organisation {|lead| lead.association(:organisation)}
  f.contact      {|lead| lead.association(:contact, :organisation => lead.organisation)}
  f.status_code 0
  
  f.sales   {|lead| lead.association(:sales)}
  
  # f.source_id  # create a polmorpic source
  
end
