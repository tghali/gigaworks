module Connie
  class Dictionary
    
    attr_accessor :name, :module_name
    
    def initialize(dictionary_name)
      @name = dictionary_name
      @module_name = dictionary_name.gsub(%r{(?:^|_)([a-z])?}) { $1.upcase }
      
      #TODO: Check the format of the dictionary name
      raise DictionaryNameNotAllowed if %w(Dictionary Parser).include? @module_name      
      
      load_dictionary_files_and_modules
      
      Connie.register_dictionary self
    end
    
    def inspect
      from_the_module = Connie.const_defined?(@module_name) ? Connie.const_get(@module_name).instance_methods : []

      all_the_methods = @word_lists.keys.concat from_the_module
      
      "#{}<#{self.class} - Connie::#{@module_name} - #{all_the_methods.join(' ')}>"
    end
    
    def interpolate string
      Connie::Parser.process string, self
    end
    
    alias :i :interpolate
    
    def load_dictionary_files_and_modules
      @word_lists = []
      
      Connie.dictionaries_paths.each do |dictionaries_path|
        @word_lists.concat Dir[File.join dictionaries_path, @name, '*']
        @word_lists.concat Dir[File.join(dictionaries_path, "#{@name}.*")]
      end

      # Indexes the dictionary files into an array
      @word_lists = @word_lists.inject({}) {|a,f| a[f.split(%r{[./]}).last.to_sym]=f; a}
      
      @word_lists.delete :rb
      
      # Defines methods based on word lists
      @word_lists.keys.each do |list|
        instance_eval <<-LIST
        def #{list} options={}
          interpolate Connie.pick_a_line_from @word_lists[:#{list}], options[:line]
        end
        LIST
      end
      
      # Find and load modules
      modules = []
      Connie.dictionaries_paths.each do |dictionaries_path|
        modules.concat Dir[File.join dictionaries_path, "#{@name}.rb"]
      end
      modules.each {|m| require m}
      
      extend Connie.const_get(@module_name) if Connie.const_defined?(@module_name)
    end
          
  end
end