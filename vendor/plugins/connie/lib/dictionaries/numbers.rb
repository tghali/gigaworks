module Connie
  module Numbers
   
   def telephone
    Connie(':d{2} :d{7,9}')
   end
   
   def uk_mobile_phone
     Connie('07 :d{3} :d{6,8}')
    end
   
   def international_telephone
      Connie('+:d{2} :d{3,5} :d{7,9}')
   end
    
  end
end