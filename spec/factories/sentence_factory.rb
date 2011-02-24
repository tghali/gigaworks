# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :sentence do |f|
  f.text {Array.new(n) {Connie(:words).english}.join(" ") }
  f.language Connie [:en, :fr, :it, :ar, :es, :de]
end

Factory.define :sentence_with_translation, :class => Sentence do |f|
  f.text "Base"
  f.language :en
  f.translations {|s| [(s.association :translation_pair, :language => :ar, :text => "#{s.text} in Arabic")]}
end
