# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :lead do |f|
  f.referent_id 1
  f.organization_id 1
  f.status_code 1
end
