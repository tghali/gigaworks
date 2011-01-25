class Translation
  include Mongoid::Document
  
  references_one :word
  references_one :sentence
  
  # field :author, :type => Departements::Languages
end
