class CreateProspects < ActiveRecord::Migration
  def self.up
    create_table :prospects do |t|
      t.string :name 
      t.string :email 
      t.string :phone 
      t.string :country 
      t.string :state 
      t.string :city 
      t.string :subject 
      t.string :message 
      t.string :source_from
      
      t.timestamps
    end
  end

  def self.down
    drop_table :prospects
  end
end
