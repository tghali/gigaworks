class AddFieldCommentSentence < ActiveRecord::Migration
  def self.up
	   add_column :sentences,:comment,:string
	   add_column :sentences,:description,:string
  end

  def self.down
	   remove_column :sentences,:comment
	   remove_column :sentences,:description
  end
end
