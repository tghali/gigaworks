# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :organization do |f|
  f.name {Connie(:names).company}
  f.country_code {Connie ['gb', 'it', 'es', 'fr', 'jp']}
end
