module Departements
  
  class Languages < Departement
    default_scope where(:name_code => Departement::NAMES.index(:languages))
    
    def self.for(user)
      self.find_by_user_id(user.id)
    end
    
  end
  
end