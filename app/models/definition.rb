class Definition
  include Mongoid::Document
  
  field :kind
  field :text
  field :pronunciation
  
  embedded_in :word
  
  # references_and_referenced_in_many :occurrences, :class_name => WordOccurrence
  # field :occurrences_count
  
  # references_and_referenced_in_many :synonims, :class_name => Word
  # references_and_referenced_in_many :examples, :class_name => Sentence
end
