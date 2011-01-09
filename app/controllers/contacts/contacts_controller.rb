class Contacts::ContactsController < ApplicationController
  
  def index
    source = can?(:administer, :crm) ? Contact.scoped : Contact.shared
    @contacts = load_in_table source, :default_view => 'list' do |tabelle|
      tabelle.filterables %w( first_name last_name )
      tabelle.sortables %w( first_name last_name created_at updated_at)
      tabelle.load_per_page :list => 28, :grid => 24
    end
  end
  
end
