module Departements
  
  class Languages < Departement
    default_scope where(:name_code => Departement::NAMES.index(:languages))
  end
  
end