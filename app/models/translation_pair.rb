class TranslationPair < ActiveRecord::Base

  belongs_to :sentence
  has_one    :author,     :class_name => 'User'
  
  has_one_baked_in :language, :names => Gigavine::Preferences.translated_languages
  
  validate :disallow_same_language_translations
  validates_presence_of   :language_code, :text, :sentence
  
  alias :source :sentence
  
  def disallow_same_language_translations
    if self.sentence.language_code == self.language_code
      errors.add(:language, 'You can\'t add a translation in the same language as the source')
    end
  end  
  
  def self.translates(sentence)
    where(:sentence_id => sentence)
  end

end
