# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :activity do |f|
  f.agent_id 1
  f.lead_id 1
  f.type_code 1
  f.note "MyText"
  f.due "2010-08-09 17:38:30"
end
