class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
	t.string :acronym
	t.string :name
	t.string :author_id
      t.timestamps
    end
  end

  def self.down
    drop_table :languages
  end
end
