require 'spec_helper'

describe Sentence do
  
  context "translations" do
    
    it "is possible to add translations" do
      o = Factory :sentence,  :language => :en, :text => 'Hello, sir!'
      t1 = Factory :sentence, :language => :it, :text => 'Salve, signore!'
      t2 = Factory :sentence, :language => :fr, :text => 'Bonjour, monsieur!'
      
      o.translations << t1
      
      o.save!
      
      # debugger
      
      t1.source.should eql(o)
      
      TranslationPair.where(:source_id => o, :result_id => t1).first.should eql(t1.translation_source)
      
      o.translations.first.should eql(t1)
      
    end
    
    it "does not allow for two sentences in the same language to translate each other" do
      o =  Factory :sentence, :language => :en, :text => 'Hello, sir!'
      t1 = Factory :sentence, :language => :en, :text => 'Good Day, sir!'
      
      lambda { o.translations << t1 }.should raise_error(ActiveRecord::RecordInvalid)
    end
        
    it "works by build and update and plays nice with controllers" do
      o = Factory :sentence, :language => :en, :text => 'Hello, sir!'
      
      sentence = o.translations.build(:language => :fr, :text => 'Bonjour, monsieur!')
      
      o.save
      
      o.reload
      o.translations.should_not be_empty
    end
    
    it "finds sentences that are not a translation" do
      o1 = Factory :sentence, :language => :en, :text => 'Hello, sir!'
      o2 = Factory :sentence, :language => :en, :text => 'This car is really fast'
      t1 = Factory :sentence, :language => :it, :text => 'Salve, signore!'
      o1.translations << t1
      
      Sentence.originals.all.should eql([o1, o2])
    end
    
    it "finds sentences that are translations" do
      o1 = Factory :sentence, :language => :en, :text => 'Hello, sir!'
      o2 = Factory :sentence, :language => :en, :text => 'This car is really fast'
      t1 = Factory :sentence, :language => :it, :text => 'Salve, signore!'
      o1.translations << t1
      
      Sentence.translations.all.should eql([t1])
    end
    
    
  end
end
