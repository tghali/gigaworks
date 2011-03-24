class AddRealmToTags < ActiveRecord::Migration
  def self.up
    add_column    :tags, :realm_id, :integer
  end

  def self.down
    remove_column :tags, :realm_id
  end
end
