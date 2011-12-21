class CreateEstimates < ActiveRecord::Migration
  def self.up
    create_table :estimates do |t|
      t.string :service
      t.float :cost
      t.timestamps
    end
  end

  def self.down
    drop_table :estimates
  end
end
