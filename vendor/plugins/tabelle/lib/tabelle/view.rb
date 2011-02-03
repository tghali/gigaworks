module Tabelle
  class View
    
    attr_accessor :name
    attr_reader :options
    
    # Takes a block to define more options about a specific table view
    # 
    def initialize(name, options = {})
      @name, @options = name, options
    end
    
    def actions(*actions)
      return (@actions || []) if actions.empty?
      @actions = actions.flatten.map(&:to_sym).uniq
    end
    
    # Add a column passing a string name and options
    # LEDO: add support for i18n and an option to allow
    #   :sorts => true
    # 
    def column(name, options={})
      (@columns ||= []) << [name, options]
    end
    
    # columns iterates over each column yielding name, an hash containing classes_and_id and an options hash
    #
    # column[0] sotres the column name
    # column[1] stores the options
    # 
    def columns
      @columns
    end
    
    # Rerturns an array containing each column's name
    # 
    def column_names
      @columns.map(&:first)
    end
    
    # Returns true if a series of columns was created for the current view
    # 
    def has_columns?
      @columns != nil
    end
    
    # Returns the default name of the layout partial for a particular view
    # based on the view's name, or the chosen partial name specified by the
    # view definition.
    # 
    def layout
      @options[:partial] ? "#{@options[:partial]}_view" : "tabelle/#{name}_view"
    end
    
    # When it recieves the current tabelle state and the sorting keyword for a column it returns
    # a class to indicate wherter the column is sortable, not sortable or determining the current
    # sort order.
    # If the column can perform sorts it will also return the sort value to pass in the url and a
    # class that expresses the direction of the sort.
    # 
    def sorting_state_keyword_and_direction(state = nil, column_sorting_keyword = nil)
      if state && column_sorting_keyword
        if state == column_sorting_keyword
          [" sorting", "-#{column_sorting_keyword}", "desc"]
        elsif state[1..-1] == column_sorting_keyword
          [" sorting", column_sorting_keyword, "asc"]
        else
          [" sortable", column_sorting_keyword, "asc"]
        end
      elsif column_sorting_keyword
        [" sortable", column_sorting_keyword, "asc"]
      else
        if default = @options[:default_sort] && default == state
          [" sorting", column_sorting_keyword, "asc"]
        else
          ["", nil, nil]
        end
      end
    end
    
  end
end