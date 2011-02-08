class Word < ActiveRecord::Base
  
  has_many :definitions
  
  has_one_baked_in :language, :names => Gigavine::Preferences.translated_languages
  
  validates_presence_of   :language_code, :word
  validates_uniqueness_of :language_code, :scope => :word
  
  accepts_nested_attributes_for :definitions, :allow_destroy => true, :reject_if => proc { |obj| obj[:description].blank? }
  
  def self.find_or_create_by_language_and_word(language, word)
    find_or_create_by_language_code_and_word(Gigavine::Preferences.translated_languages.index(language.to_sym), word)
  end
  
  
end
