class AddFounded < ActiveRecord::Migration
  def self.up
   add_column :gigaclients,:founded,:string
   add_column :gigaclients,:overview,:string
   add_column :gigaclients,:number_of_employ,:string
  end

  def self.down
   remove_column :gigaclients,:founded
   remove_column :gigaclients,:overview
   remove_column :gigaclients,:number_of_employ
  end
end
