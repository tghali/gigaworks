class Translation
  include Mongoid::Document
  
  references_one :word
  references_many :sentences, :class_name => 'TranslationPair'
  
  references_one :author, :type => Departements::Languages
end
