class Word
  include Mongoid::Document
  
  field :word
  field :pronunciation
  
  field :language
  field :origin
  
  embeds_many :definitions
  referenced_in :translation
  
  accepts_nested_attributes_for :definitions
  
  validates_presence_of :word, :language
  validates :word, :presence => true, :uniqueness => {:scope => :language}
  
end
