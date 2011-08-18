class MainAcccountIdGigausers < ActiveRecord::Migration
  def self.up
	  
	  add_column  :gigausers,:main_account_id,  :integer
  end

  def self.down
	  remove_column  :gigausers,:main_account_id
  end
end
