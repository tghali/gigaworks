# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :contact do |f|
  def f.full_name &block
    title, first, last = block.call
    self.first_name first
    self.last_name  last
    self.title      title
  end
  
  f.full_name {(Connie(:names).first_with_title << Connie(:names).last)}
  f.organization  {|contact| Connie? ? contact.association(:organization) : nil}
  f.timezone_code {Connie ['GMT', 'PST', 'EST']}
  f.email         {|c| "#{c.first_name}.#{c.last_name}@example.com"}
  f.telephone     {Connie(:numbers).international_telephone}
  
  f.details       { |contact| Array.new(rand 3).map {contact.association :detail} }
end


