module Tabelle
  module Controller
    
  private
  
    # Given a model or scoped model, load in table reads the appropriate
    # tabelle parameters (current views, sort order, filters and additional
    # scopes) and appends them to the query. It returns a tabelle collection:
    # basically an array that can return the tabelle object with all the
    # state information about the view.
    # 
    # It provides a dsl to customize which attributes coming from the user
    # will be allowed to be chained in the query.
    # 
    #   # controllers/users_controller.rb:
    #
    #   @users = load_in_table User, :include => [:password_reset_key, :role] do |tabelle|
    #     tabelle.filterables %w( user_name first_name last_name )
    #     tabelle.sortables %w( user_name created_at updated_at)
    #     tabelle.scopes %w(:with_status)
    #     tabelle.load_per_page = :table => 30, :grid => 15
    #   end
    #
    #   respond_to do |format|
    #     format.js { render @users, :layout => "ajax_layout", :locals => {:tabelle => @users.tabelle} }
    #     format.html {render :index }
    #   end
    # 
    def load_in_table(object, options = {})
      presenter_options, find_options = options.partition {|k,v| Tabelle::Presenter.options.include? k.to_sym}.map {|side| Hash[*side.flatten]}
      
      tabelle = Tabelle::Presenter.new(presenter_options)

      yield tabelle
      
      tabelle.read_params params
      
      custom_scoped_object = tabelle.scopes_and_args.inject(object) do |object, scope|
        scope, args = *scope
        if args == 't'
          object.send scope.to_sym
        else
          object.send scope.to_sym, *args
        end
      end
      
      tabelle.item_count = custom_scoped_object.scoped(tabelle.filter_conditions).count find_options.except(:include)

      collection = custom_scoped_object.scoped(tabelle.conditions)
      tabelle.model_name = object.model_name
      
      def collection.tabelle
        @tabelle
      end
      
      collection.instance_variable_set('@tabelle', tabelle)
      
      collection
    end
    
  end
end