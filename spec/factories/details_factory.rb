# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :detail do |f|
  
  def f.random_detail &block
    property, type, value = block.call
    self.property property
    self.type     type
    self.value    value
  end
  
  f.random_detail do
    case Connie [:email, :telephone, :url, :address]
    when :email
      [:URL,
       Connie(Gigaworks::Preferences.contact_detail_types),
       "#{Connie(:names).company}@example.com"]
    when :telephone
      [:TEL,
       Connie(Gigaworks::Preferences.contact_detail_types),
       Connie(:numbers).international_telephone]
    when :url
      [:URL,
       Connie(Gigaworks::Preferences.contact_detail_types),
       "http://#{Connie(:names).company}.#{Connie(:net).top_level_domain}"]
    when :address
      [:ADR,
       Connie(Gigaworks::Preferences.contact_detail_types),
       Connie(:geo).full_address]
    end
  end
  
end
