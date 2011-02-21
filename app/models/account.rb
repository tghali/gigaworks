class Account < ActiveRecord::Base
  
  belongs_to :organisation
  
  has_many   :account_memberships
             
  has_many   :users, :through => :account_memberships

  belongs_to    :sales_representative, :class_name => 'Departements::Sales'
  
  has_one_baked_in  :status, :names =>  [:active, :completed, :frozen, :blocked],
                             :groups => {:accessible => [:active, :terminated, :frozen]}
  
  
end
