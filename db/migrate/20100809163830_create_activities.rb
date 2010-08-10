class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer  :agent_id
      t.integer  :lead_id
      t.integer  :type_code
      t.text     :note
      t.datetime :due

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
