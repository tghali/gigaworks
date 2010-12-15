# create models and associations from a table
Given(/^the following #{capture_plural_factory} and (\w*) #{capture_plural_factory} exists?:?$/) do |plural_factory, association, plural_associated_factory, table|
  name = plural_factory.singularize
  associated_name = plural_associated_factory.singularize
  
  table.hashes.each do |hash|
    associated_hash, hash = hash.partition {|k,v| String(k) =~ /^#{association}_.*/}.map {|h| Hash[*h.flatten]}

    create_model(associated_name, Hash[*associated_hash.map {|k,v| [String(k).gsub(/^#{association}_/,''),v]}.flatten] )
    
    associated = created_model(associated_name)
    create_model(name, hash.merge(association => associated))
  end
end