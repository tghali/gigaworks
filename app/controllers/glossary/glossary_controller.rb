class Glossary::GlossaryController < ApplicationController
  
  def index
    @words = load_in_table Word, :include => [:definition], :default_view => 'list' do |tabelle|
      tabelle.filterables %w( word )
      tabelle.scopes %w( language )
      tabelle.load_per_page :list => 28, :grid => 24
    end
    
  end
  
end
