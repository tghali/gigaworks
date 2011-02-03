class Translation
  include Mongoid::Document
  
  references_and_referenced_in_many :sentences, :class_name => 'TranslationPair'
  
  references_one :author, :type => Departements::Languages
end
