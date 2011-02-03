class TranslationPair < ActiveRecord::Base
  
  
  belongs_to :source, :class_name => 'Sentence', :counter_cache => :translation_pairs_count
  belongs_to :result, :class_name => 'Sentence', :dependent => :destroy
  
  validates_uniqueness_of :result_id
  
  validate :disallow_same_language_translations
  validate :prevent_translating_translations
  
  def disallow_same_language_translations
    if source.language == result.language
      errors.add(:result, 'You can\'t add a translation in the same language as the source')
    end
  end
  
  def prevent_translating_translations
    unless TranslationPair.where(:result_id => source_id).empty?
      errors.add(:result, 'You can\'t add a translation to a sentence that is itself a translation')
    end
  end
  
  
  def self.translates(sentence)
    where(:source_id => sentence)
  end

end
