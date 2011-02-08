class Definition < ActiveRecord::Base
  
  belongs_to :word
  
  has_one_baked_in :kind, :names => [:noun, :adjective, :adverb, :verb, :preposition, :pronoun, :conjunction, :exclamation]
  
  has_many :definition_examples
  has_many :examples, :through => :definition_examples, :source => :sentence
  
  has_many :translations do
    
    # This can be moved as a scope in the translation model
    def to(language)
       joins(:word).where(:words => {:language_code => Gigavine::Preferences.translated_languages.index(language.to_sym)})
    end
  
  end
  
  has_many :translated_words, :through => :translations, :source => :word
  
  validates_length_of :description, :minimum => 4,
                                    :maximum => 50,
                                    :tokenizer => lambda { |str| str.scan(/\w+/) },
                                    :too_short => "can't be less than %{count} words",
                                    :too_long =>  "can't be longer than %{count} words"
  
  validates_presence_of :kind_code
  
  accepts_nested_attributes_for :examples,         :allow_destroy => true, :reject_if => proc { |obj| obj[:text].blank? }
  accepts_nested_attributes_for :translated_words, :allow_destroy => true, :reject_if => proc { |obj| obj[:word].blank? }
  
  
  # moving this to an association extension would be classy
  def add_translation(word)
    w = Word.find_or_create_by_language_code_and_word Gigavine::Preferences.translated_languages.index(word[:language].to_sym), word[:word]
    translated_words << w
    w
  end
  
  
end
