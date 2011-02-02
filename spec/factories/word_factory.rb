# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :word do |f|
  f.word {Connie(:words).english}
  f.language Connie([:en, :fr, :it, :ar, :es, :de])
  f.definitions { |word| Array.new(rand(2)+1) {Factory :definition}}
end
