class DefinitionExample < ActiveRecord::Base
  
  belongs_to :definition
  belongs_to :sentence
  
end
