class AddFieldProspects < ActiveRecord::Migration
  def self.up
	  add_column :prospects,:source_from,:string
  end

  def self.down
	   remove_column :prospects,:source_from
  end
end
