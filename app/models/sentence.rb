class Sentence < ActiveRecord::Base
  
  has_one_baked_in :language, :names => Gigavine::Preferences.translated_languages
  
  validates_presence_of   :language_code, :text
  validates_uniqueness_of :text, :scope => :language_code,:case_sensitive => false
  
  has_many   :translations,  :class_name => 'TranslationPair', :dependent => :destroy
  has_one    :author,     :class_name => 'User'
  belongs_to :flagged_by, :class_name => 'User'
  has_many   :comments, :as => :commentable
  
  accepts_nested_attributes_for :translations, :allow_destroy => true, :reject_if => proc { |obj| obj[:text].blank?  }
  attr_accessible :language, :text, :definition, :translations_attributes
  
  scope :flagged, where(self.arel_table[:flagged_by_id].not_eq(nil)).order('updated_at DESC')
  scope :recent,  where(self.arel_table[:updated_at].gt(2.weeks.ago)).order('updated_at DESC')
  
  
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
      
      return sentence unless sentence.save
    end
    
    return sentence unless new_translations_attributes
    
    if sentence.translations.count > 0
      offset = sentence.translations.count
      
      new_translations_attributes = Hash[*new_translations_attributes.map {|k,v| ["#{k.to_i + offset}",v]}.flatten]
    end
    
    sentence.attributes = {:translations_attributes => new_translations_attributes}
    
    return sentence  
  end
  
  
  def flagged?
    self.flagged_by != nil
  end
  
  def toggle_flag user
    if self.flagged? 
      self.flagged_by = nil
    else
      self.flagged_by = user
    end
  end
  
  # def translations_attributes=attributes
  #   raise attributes.inspect
  # end
  
end
