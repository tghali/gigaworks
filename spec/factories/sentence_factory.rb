# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :sentence do |f|
  f.text {Array.new(n) {Connie(:words).english}.join(" ") }
  f.language Connie [:en, :fr, :it, :ar, :es, :de]
end
