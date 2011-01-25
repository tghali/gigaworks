class Word
  include Mongoid::Document
  field :word
  field :language

  embeds_many :definitions
end
