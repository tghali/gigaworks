require 'spec_helper'

describe Sentence do
  
  context "translations" do
    
    it "is possible to add translations" do
      o = Factory :sentence,  :language => :en, :text => 'Hello, sir!'
      
      t1 = o.translations.create(:language => :it, :text => 'Salve, signore!')
      
      # debugger
      
      t1.sentence.should eql(o)
      
      o.translations.first.should eql(t1)
      
    end
    
    it "does not allow for the translation to be in the same language as the source" do
      o =  Factory :sentence, :language => :en, :text => 'Hello, sir!'
      
      lambda { o.translations.create!(:language => :en, :text => 'Good Day, sir!') }.should raise_error(ActiveRecord::RecordInvalid)
    end
        
    it "works by build and update and plays nice with controllers" do
      o = Factory :sentence, :language => :en, :text => 'Hello, sir!'
      
      translation = o.translations.build(:language => :fr, :text => 'Bonjour, monsieur!')
      
      o.save
      
      o.reload
      o.translations.should_not be_empty
    end
    
    it "supports a controller that finds_or_create -finding- with nested attributes" do
      o = Factory :sentence, :language => :en, :text => 'Hello, sir!'
      
      s = Sentence.find_or_create_with_nested_attributes({
        :language => :en,
        :text => 'Hello, sir!',
        :translations_attributes => {
          "0" => {:language => :it, :text => 'Buongiorno, signore!'},
          "1" => {:language => :fr, :text => 'Bonjour, monsieur!'}
        }
      })
      
      s.save.should be_true
      s.should eql(o.reload)
      s.translations.count.should eql(2)
    end
    
    it "supports a controller that finds_or_create -creating- with nested attributes" do
      s = Sentence.find_or_create_with_nested_attributes({
        :language => :en,
        :text => 'hello world',
        :translations_attributes => {
          "0" => {:language => :it, :text => 'ciao mondo'},
          "1" => {:language => :fr, :text => 'bonjour monde'}
        }
      })
      
      s.save.should be_true
      s.should eql(o.reload)
      s.translations.count.should eql(2)
    end
    
  end
end
