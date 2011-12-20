class AddColumnIpcolumn < ActiveRecord::Migration
  def self.up
   add_column :frontend_pages,:ippadd,:string
  end

  def self.down
   remove_column :frontend_pages,:ippadd
  end
end
