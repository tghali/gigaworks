class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer   :agent_id
      t.integer   :target_id
      t.integer   :type_code
      t.datetime  :due_on
      t.timestamp :due_at
      t.text      :note

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
