class AddFieldAboutmeTalent < ActiveRecord::Migration
  def self.up
   add_column :talents,:about_me,:string
  end

  def self.down
   remove_column :talents,:about_me
  end
end
