class CreateSalesActivities < ActiveRecord::Migration
  def self.up
    create_table :sales_activities do |t|
      t.integer :agent_id
      t.integer :lead_id
      t.integer :type_code
      t.datetime :due_on
      t.timestamp :due_at
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :sales_activities
  end
end
