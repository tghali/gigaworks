class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.integer :organization_id
      t.integer :status_code
      t.date :due_on

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
