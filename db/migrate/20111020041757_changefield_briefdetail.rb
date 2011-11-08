class ChangefieldBriefdetail < ActiveRecord::Migration
  def self.up
	  #~ change_table :brief_details do |t|
		#~ t.rename :string, :section_name
	#~ end
  end

  def self.down
	  #~ t.rename  :section_name, :string
  end
end
