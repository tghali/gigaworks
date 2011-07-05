class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :title
      t.string :name
      t.string :company
      t.string :industry
      t.string :country
      t.integer :author_id
      t.string :first_line
      t.string :second_line
      t.string :city
      t.string :state
      t.string :mobile
      t.string :phone
      t.string :po_box

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
