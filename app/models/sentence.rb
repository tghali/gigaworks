class Sentence < ActiveRecord::Base
  
  has_one_baked_in :language, :names => Gigavine::Preferences.translated_languages
  
  validates_presence_of   :language_code, :text
  
  has_many :definition_examples
  has_many :definitions, :through => :definition_examples
  
  has_many :translation_pairs,  :foreign_key => 'source_id', :dependent => :destroy
  has_one  :translation_source, :class_name => 'TranslationPair', :foreign_key => 'result_id'
  
  has_many :translations, :through => :translation_pairs,
                          :class_name => 'Sentence', :source => :result,
                          :dependent => :destroy
                          # :condition => translations
  
  has_one  :source, :through => :translation_source, :class_name => 'Sentence', :foreign_key => 'source_id'
  
  accepts_nested_attributes_for :translations, :allow_destroy => true, :reject_if => proc { |obj| obj[:text].blank? }
  
  def self.translations
    joins(:source)
  end
  
  def self.originals
    # joins(:translation_pairs).where(:'translation_pairs' => nil)
  end
  
end
