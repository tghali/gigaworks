class TranslationPair
  include Mongoid::Document
  
  references_one :author, :class_name => Departements::Languages
  
  #add rating
end
