module Tabelle
  class Presenter
    
    def self.options
      [:max_page_links, :max_items_per_page, :default_view]
    end
    
    def initialize(options)
      @state, @scope_styles, @options = {:page => 1, :scopes => {}}, {}, {:max_page_links => 7,
                                                                          :max_items_per_page => 15,
                                                                          :default_view => 'simple_table'}
      
      @options.merge! options
    end
    
    attr_accessor :state, :options, :model_name, :item_count, :title
    
    # Parameters about tabelle state passed via GET.
    # LEDOUBT: What about those passed via POST? Like selected items...
    # 
    GET_PARAMS = [:page, :view, :filters, :scopes, :max_items, :sort]
    
    # Copies into tabelle the relevant params from the controler hash
    # 
    def read_params(params)
      GET_PARAMS.each do |key|
        @state[key] = params[key] if params[key]
      end
      
      @state[:page] = @state[:page].to_i if @state[:page]
      
    end
    
    # Returns the names of active scopes and their arguments if it's an Array
    # 
    def scopes_and_args
      @state[:scopes]
    end
    
    # Returns the name of the class of the collection, or it just returns
    # 
    def collection_title
      @model_name.human.pluralize.titleize
    end
    
    def load_per_page max_items_per_page
      case max_items_per_page
      when Hash then @options[:max_items_per_page] = max_items_per_page[(@state[:view]||@options[:default_view]).to_sym]
      else @options[:max_items_per_page] = max_items_per_page
      end
    end
    
    # Parses the filters sent in the request, according to the tabelle
    # configuration and returns the SQL query to filter results using LIKE
    # 
    def query_from_filters filters = nil, filterables = nil
      return nil unless filters and filterables
      
      # Separates keywords that refer to a specific attribute form general keywords 
      specific_keywords, general_keywords = filters.partition {|key| key.match "^(#{filterables.join('|')})\:"}

      # Converts the 'specific' array into an array of attribute/filter_keyword values
      specific_keywords.map! {|key| key.match("^(#{filterables.join('|')})(?:\:\s?)(.*)$").to_a[1,2]}
      
      # Add general filter for each filterable attribute (OR)
      query = general_keywords.inject([[]]) do |query, keyword|
        query[0] << (filterables.
          map{|attribute| "#{attribute} LIKE ?"}.join(' OR '))
        query.concat(["%#{keyword}%"]*filterables.size)
      end
      
      # Add attribute specific filters
      query = specific_keywords.inject(query) do |query, attribute_and_keyword|
        query[0] << "#{attribute_and_keyword[0]} LIKE ?"
        query << "%#{attribute_and_keyword[1]}%"
      end
      
      # Assemble all the filters together in a query
      query[0] = query[0].join ' AND '
      
      return query
    end
    
    # Returns the conditions hash with the parsed filters
    # 
    def filter_conditions
      @filter_conditions ||= {:conditions => query_from_filters(@state[:filters],@options[:filterables])}
    end
    
    # Parses the order parameter and makes sure that the attribute has been specified as sortable.
    # 
    def parse_order(order = nil)
      return nil unless order
      
      unless order[0] == '-'
        @options[:sortables].include?(order) ? order : nil 
      else
        order.slice![0]
        @options[:sortables].include?(order) ? "#{order} DESC" : nil
      end
    end
    
    def total_pages
      (@item_count > 0 ? @item_count : 1) /@options[:max_items_per_page]
    end
    
    # Returns a filtered query that has order limit and sort too.
    # 
    def conditions
      page = (@state[:page] > total_pages) ? total_pages : @state[:page]
      
      filter_conditions.merge :limit  => @options[:max_items_per_page],
                              :offset => @options[:max_items_per_page]*(page - 1),
                              :order  => parse_order(@state[:sort])
    end
    
    # Returns an array of views or the specified view
    # 
    def views view_name = nil
      @views ||= [Tabelle::View.new(@options[:default_view])]
      if view_name
        @views.select {|v| v.name == view_name}.first or raise 'View not found'
      else
        @views
      end
    end
    
    # Without any argument returns the current view, if a symbol is passed
    # Creates and lets you configure a view through a block.
    # 
    def view(*args)
      unless args.empty?
        view = Tabelle::View.new(*args)
        if @views 
          @views << view
        else
          @views = [view]
          @options[:default_view] = view.name 
        end
      
        yield view if block_given?
        
        nil
      else
        views(state[:view] || @options[:default_view])
      end
    end
    
    # Returns true if there's more than one view for this table
    # 
    def has_views?
      @views.size > 1
    end
    
    # Accepts an array of symbols/strings or a single symbol string, those
    # will be the only scopes allowed to be appended to the query by the user
    # request.
    # 
    def scopes(*scopes)
      return @scopes if scopes.empty?
      @scopes = scopes.flatten.map(&:to_sym).uniq
    end
    
    # Accepts an array of symbols/strings or a single symbol string, those
    # will be the only filters allowed to be appended to the query by the user
    # request.
    # 
    def filterables(*filters)
      return @options[:filterables] if filters.empty?
      @options[:filterables] = filters.flatten.map(&:to_sym).uniq
    end
    
    # Returns wherter or not a tabelle is configured to accept filters
    # 
    def has_filters?
      @options[:filterables] != nil
    end
    
    # Accepts an array of symbols/strings or a single symbol string, those
    # will be the only parameters allowed to be sortes by the user request.
    # 
    def sortables(*attributes)
      return @options[:sortables] if attributes.empty?
      @options[:sortables] = attributes.flatten.map(&:to_sym).uniq
    end

    # Returns wherter or not a tabelle is configured to allow the user to
    # scope the query.
    # 
    def has_scopes?
      @scopes != nil
    end
    
    # Accepts a block that will be rendered as the UI for that scope
    # 
    def fields_for_scope(scope, &block)
      @scope_styles[scope] = block
    end
    
    # Either executes the one-liner form captured in the view definition or passes label and url
    # with parameters back to the layout file where it's called.
    # 
    def scope_buttons
      @scopes.each do |scope|
        if @state[:scopes][scope]
          status = "active"
          remaining_scopes = state[:scopes].except(scope)
          params = remaining_scopes.empty? ? state.except(:scopes) : state.merge(:scopes => remaining_scopes)
        else
          status = nil
        end
        
        if defined_scope_form = @scope_styles[scope]
          # USE instance exec!!
          # view = eval('self', defined_scope_form)
          # view.fields_for(:scopes, :index => scope) do |builder|
          #   defined_scope_form.call(builder, status)
          # end
        else
          params ||= (state.deep_merge(:scopes => {scope => 't'}))
          yield scope, params, status
        end
        
      end
    end
    
    # Returns wherter or not a tabelle is configured to allow the user to
    # perform actions on the whole collection.
    # 
    def has_actions?
      view.actions.empty? ? false : true
    end
    
    # Returns the actions that the user is allowed to perform on the whole
    # collection.
    # 
    def actions
      view.actions || []
    end
    
    def id=(id)
      @options[:id]=id
    end
    
    def id
      @options[:id]
    end
    
    # Returns the location of the layout file for tabelle.
    # 
    def layout
      "tabelle/layout"
    end
    
    # Returns the name of the class tabelle is collectin in snake case
    # 
    def model_name
      @model_name.underscore.to_s
    end
    
    # Returns the name of the collection partial used to render this view
    #   # eg:
    #   _name_of_the_clas.haml
    # 
    #   # eg(more than one tabelle view present):
    #   _name_of_the_class_name_of_the_view.haml
    # 
    def partial
      (@views.size > 1) ?  "#{model_name}_#{view.name.singularize}" : model_name
    end
    
    # Returns wherter or not the results have to be displayed in more than one
    # page for this particular view
    # 
    def multiple_pages?
      @item_count > @options[:max_items_per_page]
    end
    
    # Returns an 'zipped' array with names and page number for the page index
    # for the tabelle results.
    # 
    def page_index
      page = @state[:page]
      links = @options[:max_page_links]
      total_pages = self.total_pages
      
      bck = ((page > links ? page-links : 1)..page).entries.reverse
      fwd = (page..((total_pages - page > links ? page+links : total_pages))).entries
    
      order = fwd.size > page ? fwd.zip(bck) : bck.zip(fwd)
      order = order.flatten.compact.uniq[0,links].sort
    
      order.map! {|p| p==page ? [p, '#'] : [p, @state.merge(:page => p)]}
      
      if order[0][0]!=1
        order[1] = ['...', nil]
        order[0] = [1, @state.except(:page)]
      end
      if order[-1][0]!=total_pages
        order[-2] = ['...', nil]
        order[-1] = [total_pages, @state.merge(:page => total_pages)]
      end
      
      order
    end
    
    
  end
end