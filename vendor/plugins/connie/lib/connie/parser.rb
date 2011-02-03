module Connie
  class Parser
    
    #TODO: implement negative lookahead to allow escaping \: and escaping the escaping symbol itself \\
    attr_accessor :dictionary
    
    @syntax = {# :method or :dictionary.method
               %r{((?:[\\]+)?\:[a-z]\w+(?:.\w+)?)} => lambda do |dictionary_and_method|
                arguments = dictionary_and_method[1..-1].split('.').map &:to_sym
                case arguments.size
                when 2 then Connie[arguments[0]].send arguments[1]
                when 1 then dictionary.send arguments[0]
                end
               end,
               # :d - one digit
               %r{((?:[\\]+)?\:[wWd])(?:[^\w\{])} => lambda do |letter_or_digit|
                Connie.formats letter_or_digit[1].to_sym
               end,
               # :w{2,4} - two to four letters
               %r{((?:[\\]+)?\:[wWd](?:\{\d+(?:,\d+)?\}))} => lambda do |character_and_frequency|
                character, f_min, f_max = character_and_frequency[1..-1].match(%r{(\w)(?:\{(\d+)(?:,(\d+))?\})})[1..-1]
                Connie.formats character.to_sym, f_min.to_i, f_max.to_i
               end
              }
        
    def self.process string_to_parse, dictionary = Connie[:names]
      tokenized = string_to_parse.split Regexp.union(@syntax.keys)
            
      Connie::Parser.new(dictionary).apply_syntax(tokenized).join
    end
    
    def initialize(dictionary)
      @dictionary = dictionary
    end
    
    # calls trasform on the tokens marked for interpolation and deals with escaping
    def apply_syntax tokens
      tokens.map do |t|
        if t.match '\:[a-z]'
          transform t
        elsif t[0] && t[0].chr == '\\' # some level of escaping is present
          t.match %r{([\\]+)\:}
          raise 'I don\' speak escapeese yet!'
        else
          t
        end
      end
    end
    
    # Interpolates a syntax token
    def transform string
      result = nil
      syntax.each_pair { |k,func| result = instance_exec(string, &func) if string.match(k) }
      return result
    end
    
  private
    
    def syntax
      @rebound_syntax ||= self.class.instance_variable_get('@syntax')
    end
    
  end
end