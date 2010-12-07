# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :sales_activity do |f|
  f.agent_id 1
  f.lead_id 1
  f.type_code 1
  f.due_on "2010-12-05 18:25:44"
  f.due_at "2010-12-05 18:25:44"
  f.note "MyText"
end
