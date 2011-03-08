module Departements
  
  class Languages < Departement
    default_scope where(:name_code => Departement::NAMES.index(:languages))
    
    has_many :flagged_sentences, :class_name => 'Sentence', :foreign_key => 'flagged_by_id'
    
    def self.for(user)
      self.find_by_user_id(user.id)
    end
    
  end
  
  
  class Sales < Departement
    default_scope where(:name_code => Departement::NAMES.index(:sales))
    
    def self.for(user)
      self.find_by_user_id(user.id)
    end
    
  end
  
  
end