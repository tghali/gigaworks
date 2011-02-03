class Definition
  include Mongoid::Document
  
  field :kind
  field :text
  
  embedded_in :word
  
  # references_and_referenced_in_many :occurrences, :class_name => WordOccurrence
  # field :occurrences_count
  
  references_and_referenced_in_many :synonims,     :class_name => 'Word'
  references_and_referenced_in_many :translations, :class_name => 'Word'
  references_and_referenced_in_many :examples,     :class_name => 'Sentence'
  
  accepts_nested_attributes_for :examples, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  
  
  
  def self.kinds
    [:noun, :adjective, :adverb, :verb, :preposition, :pronoun, :conjunction]
  end
  
end
