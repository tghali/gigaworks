module Tabelle
  module Helper
    
    # views/users/index.html.haml
    # 
    # - table_for @users do |tabelle|
    #   
    #   - tabelle.fields_for_scope :with_status do |user_status, state|
    #     %li{:class => state}
    #       - user_status.select 'status', options_for_status_select
    #
    #   - tabelle.add_view "icons", :partial => :grid
    #   
    #   - tabelle.add_view "table", :partial => :table do |table|
    #     - table.actions %w(verify suspend delete)
    #     - table.add_column "name"
    # 
    def table_for(collection)
      raise ArgumentError, 'Missing block' unless block_given?
      raise ArgumentError, 'The provided collection isn\'t a tabelle collection. Please load it using Tabelle::Controller#load_in_table' unless collection.respond_to?(:tabelle)
      
      tabelle = collection.tabelle
      yield tabelle
      render :partial => tabelle.layout, :locals => {:tabelle => tabelle, :collection => collection}
    end
    
  end
end