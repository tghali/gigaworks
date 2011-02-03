class Definition < ActiveRecord::Base
  
  belongs_to :word
  
  has_one_baked_in :kind, :names => [:noun, :adjective, :adverb, :verb, :preposition, :pronoun, :conjunction]
  
  has_many :definition_examples
  has_many :examples, :through => :definition_examples, :source => :sentence
  
  has_many :translations do
    
    # This can be moved as a scope in the translation model
    def to(language)
       joins(:word).where(:words => {:language_code => Gigavine::Preferences.translated_languages.index(language.to_sym)})
    end
  
  end
  
  has_many :translated_words, :through => :translations, :source => :word
  
  validates_length_of :description, :minimum => 6,
                                    :maximum => 50,
                                    :tokenizer => lambda { |str| str.scan(/\w+/) },
                                    :too_short => "can't be less than %{count} words",
                                    :too_long =>  "can't be longer than %{count} words"
  
  validates_presence_of :kind_code
  
  accepts_nested_attributes_for :examples,         :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :translated_words, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  
  
  def add_translation(language, word)
    w = Word.find_or_create_by_language_and_word language, word
    translated_words << w
  end
  
  
end
