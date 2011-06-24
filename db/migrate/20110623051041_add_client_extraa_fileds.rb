class AddClientExtraaFileds < ActiveRecord::Migration
  def self.up
	  add_column :gigaclients,:industry,:string
	  add_column :gigaclients,:turnover,:string
	  add_column :gigaclients,:notes,:string
  end

  def self.down
	  remove_column :gigaclients,:industry
	  remove_column :gigaclients,:turnover
	  remove_column :gigaclients,:notes
  end
end
