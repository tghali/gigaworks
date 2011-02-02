# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :definition do |f|
  f.text {Array.new(20+rand(20)) {Connie(:words).english}.join(" ")}
  # f.occurrences []
  # f.occurrences_count 0
  # f.synonims do |word|
  #   Array.new(rand 3) do
  #     if Word.count < 200
  #       [Factory(:word)]
  #     else
  #       [Word.skip(rand Word.count).first]
  #     end
  #   end
  # end
  # f.example do |word| 
  #   n = 5+rand(3)
  #   Factory :sentence, :text => Array.new(n) {Connie(:words).english}.insert(rand n, word.word).join(" ")
  # end
end
