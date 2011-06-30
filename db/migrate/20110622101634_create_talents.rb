class CreateTalents < ActiveRecord::Migration
  def self.up
    create_table :talents do |t|
      t.string :title
      t.string  :first_name
      t.string :last_name
      t.string :email  
      t.string :gender
      
      # Address
      t.string :first_line
      t.string :second_line
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.string :po_box
      
      #summary
      t.string :summary
      t.string 
      
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :talents
  end
end
