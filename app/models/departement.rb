class Departement < ActiveRecord::Base
  
  belongs_to :user
  
  has_one_baked_in  :name, :names => [:administration, :sales, :creative, :tech, :languages, :support],
                           :groups => {:project => [:creative, :languages, :administration]}
                           
  validates_uniqueness_of :name_code, :scope => :user_id
  
end
