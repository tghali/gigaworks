# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :sentence do |f|
  f.text {Array.new(n) {Connie(:words).english}.join(" ") }
  f.language Connie [:en, :fr, :it, :ar, :es, :de]
end

Factory.define :sentence_with_translation, :class => Sentence do |f|
  f.text "Base"
  f.language :en
  f.after_create  do |sentence|
    sentence.translations.create :language => :ar, :text => "#{sentence.text} in Arabic"
  end
end
