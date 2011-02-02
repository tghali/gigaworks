require 'spec_helper'

describe Factory do
  
  context "word" do
    
    it "creates words and some definitions" do
      w = Factory :word
      w.definitions.should_not be_empty
    end
    
  end
  
  context "adding translations" do
    it "creates word and definitions pairs" do
      w = Word.create(:word => 'recycling bin', :language => :en,
                      :definitions_attributes => [{:text => 'Container for rubbish',
                                                  :kind => :name}])
      w.should be_valid
      
      w.definitions.should_not be_empty
      
      w.definitions.first.translations << Word.create(:word => 'cestino', :language => :it)
      
      w.definitions.first.translations.should_not be_empty
    end    
  end
end