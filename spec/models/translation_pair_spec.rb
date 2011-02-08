require 'spec_helper'

describe TranslationPair do
  it "does not allow a translation to translate two sentences" do
    o1 = Factory :sentence, :language => :en, :text => 'Hello, sir!'
    t1 = Factory :sentence, :language => :it, :text => 'Salve, signore!'
    o2 = Factory :sentence, :language => :fr, :text => 'Bonjour Monsieur'
    
    o1.translations << t1
    
    lambda { o2.translations << t1 }.should raise_error(ActiveRecord::RecordInvalid)
    
  end
  
  it "does not allow originals to be added as translations of something else" do
    o1 = Factory :sentence, :language => :en, :text => 'Hello, sir!'
    t1 = Factory :sentence, :language => :it, :text => 'Salve, signore!'
    o2 = Factory :sentence, :language => :fr, :text => 'Bonjour, monsieur!'
    t2 = Factory :sentence, :language => :es, :text => 'Hola hombre!'
    
    o1.translations << t1
    o1.translations << t2
    
    TranslationPair.where(:source_id => o1).count.should eql(2)
    lambda {o2.translations << o1}.should raise_error(ActiveRecord::RecordInvalid)
  end
  
end
