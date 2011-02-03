module Connie
  module Creative
    
    def lorem_ipsum length = 6100
      result = ""
      line = 1
      while result.length < length
        result << lorem_ipsum_lines(:line => line)
        line += 1
      end
      
      result
    end
    
  end
end