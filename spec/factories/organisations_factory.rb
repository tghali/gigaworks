# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :organisation do |f|
  f.name {Connie(:names).company}
  f.country_code {Connie ['gb', 'it', 'ae', 'dk', 'fr', 'qa']}
end


Factory.define :client, :parent => :organisation do |c|
  c.account {|c| c.association(:account) }
end