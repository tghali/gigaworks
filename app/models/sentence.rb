class Sentence < ActiveRecord::Base
  
  has_one_baked_in :language, :names => Gigavine::Preferences.translated_languages
  
  validates_presence_of   :language_code, :text
  validates_uniqueness_of :text, :scope => :language_code,:case_sensitive => false
  
  has_many :translations,  :class_name => 'TranslationPair', :dependent => :destroy
  
  accepts_nested_attributes_for :translations, :allow_destroy => true, :reject_if => proc { |obj| obj[:text].blank?  }
  attr_accessible :language, :text, :definition, :translations_attributes
  
  def self.search text
    where('upper(text) LIKE upper(?)', text+'%')
  end
  
  def self.matches params
    where('upper(text) = upper(?)', params[:text]).where(:language_code => Gigavine::Preferences.translated_languages.index(params[:language].to_sym))[0]
  end
  
  def self.find_or_create_with_nested_attributes params
    new_translations_attributes = params.delete :translations_attributes
    
    sentence = Sentence.matches(params)
    unless sentence
      
      sentence = Sentence.new(params)
      
      return false unless sentence.save
    end
    
    return sentence unless new_translations_attributes
    
    if sentence.translations.count > 0
      offset = sentence.translations.count
      
      new_translations_attributes = Hash[*new_translations_attributes.map {|k,v| ["#{k.to_i + offset}",v]}.flatten]
    end
    
    sentence.attributes = {:translations_attributes => new_translations_attributes}
    
    return sentence
  end
  
  # def translations_attributes=attributes
  #   raise attributes.inspect
  # end
  
end
