class AddColumnCompanyTalent < ActiveRecord::Migration
  def self.up
    add_column :talents,:company,:string
  end

  def self.down
   remove_column :talents,:company
  end
end
