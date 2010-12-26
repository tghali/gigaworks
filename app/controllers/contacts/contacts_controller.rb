class Contacts::ContactsController < ApplicationController
  
  def index
    source = can?(:administer, :app) ? Contact.all : Contact.shared
    @contacts = load_in_table source do |tabelle|
      tabelle.filterables %w( first_name last_name )
      tabelle.sortables %w( user_name created_at updated_at)
      tabelle.load_per_page :table => 30, :grid => 15
    end
  end
  
end
