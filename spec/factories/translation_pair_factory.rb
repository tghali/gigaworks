# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :translation_pair do |f|
  f.source_id 1
  f.result_id 1
  f.translator_id 1
  f.status_code 1
end
