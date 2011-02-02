require 'spec_helper'

describe Word do
  
  context "creating entries" do
  
    it "can be created" do
      w = Word.create(:word => 'kind', :language => :en)
    end
  
    it "can be created with definitions" do
      w = Word.create!(:word => 'kind',
                       :language => :en,
                       :definitions => [
                         {:kind => :noun,
                          :text => "a group of people or things having similar characteristics"},
                         {:kind => :adjective,
                          :text => "having or showing a friendly, generous, and considerate nature"}
                         ])
      
      w.definitions.first.kind.should eql(:noun)
    end
  
    it "cannot be created without specifying the language" do
      w = Word.new(:word => 'supercalifragilisticexpialidocious')
    
      w.should_not be_valid
    end
  
    it "features unique word-language pairs" do
      Word.create!(:word => 'tempo', :language => :en)
    
      lambda { Word.create!(:word => 'tempo', :language => :it) }.should_not raise_error
    
      lambda { Word.create!(:word => 'tempo', :language => :en) }.should raise_error(Mongoid::Errors::Validations)
    end
  
  end
  
  context "translations" do
    it "add a translation" do
      u = Factory :user, :departements => [Departements::Languages.new]
      
      w = Word.create!(:word => 'kind',
                       :language => :en,
                       :definitions => [
                         {:kind => :noun,
                          :text => "a group of people or things having similar characteristics"},
                         {:kind => :adjective,
                          :text => "having or showing a friendly, generous, and considerate nature"}
                         ])
      
      raise w.definitions.first.translations.inspect
      #.create(:word_attributes => {:word => 'gentile', :language => :it}, :author => Departements::Languages.for(u))
    end
  end
  
end