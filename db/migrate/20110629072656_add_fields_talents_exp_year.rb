class AddFieldsTalentsExpYear < ActiveRecord::Migration
  def self.up
	  add_column :talents,:exp_years,:string
	  add_column :talents, :exp_months,:string
  end

  def self.down
	  remove_column :talents,:exp_years
	  remove_column :talents, :exp_months
  end
end
