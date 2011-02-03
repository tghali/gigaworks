module Connie
  
  class DictionaryNotFound < StandardError; end
  class DictionaryNameNotAllowed < StandardError; end
  
  @dictionaries = {}
  @alphabet = %w(a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z)
  
  def self.dictionaries_paths;@dictionaries_paths;end
  def self.dictionaries;@dictionaries;end
  
  def self.[] dictionary_name
    @dictionaries[dictionary_name.to_sym] or Dictionary.new(dictionary_name.to_s)
  end
  
  def self.register_dictionary(dictionary)
    @dictionaries[dictionary.name.to_sym] = dictionary
  end
  
  # Picks a random line from a text file or a precise line if a number is provided
  def self.pick_a_line_from(file_path, line_no = false)
    File.open file_path, 'r' do |file|
      unless line_no
        file.inject { |choice, line| rand < 1/file.lineno.to_f ? line.strip : choice }
      else
        line = line_no % (file.lineno - 1) # cycles around the file
        file.readlines[line_no-1].strip
      end
    end
  end
  
  def self.reload_dictionaries
    @dictionaries = {}
  end
  
  # Returns a random letter
  def self.letter(variant=nil)
    index = rand(26)*2
    index +=1 if variant == :uppercase
    @alphabet[index]
  end
  
  def self.digit
    rand(9)
  end
  
  def self.formats format, min = 1, max = 0
    array = max > 0 ? Array.new(rand(max-min)+min) : Array.new(min)
      
    generator = case format
    when :W then lambda {Connie.letter(:uppercase)}
    when :w then lambda {Connie.letter}
    when :d then lambda {Connie.digit.to_s}
    end
    
    array.map{generator.call}.join
  end
  
end