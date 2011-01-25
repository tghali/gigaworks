class Departement < ActiveRecord::Base
  has_one_baked_in  :name, :names => [:administration, :sales, :creative, :tech, :languages, :support],
                           :groups => {:project => [:creative, :languages, :administration]}
end
