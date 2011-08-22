class ChangeGigauserRoleField < ActiveRecord::Migration
 def self.up
 change_table :gigausers do |t|
   t.change :role_id, :string
   t.rename :role_id, :role


 end
end

def self.down
 change_table :gigausers do |t|
    t.change :role_id,:integer
   t.rename :role, :role_id

 end
end
end
