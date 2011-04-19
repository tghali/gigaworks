class Glossary::GlossaryController < ApplicationController
  log_actions_with :glossary_observer
  
  protected

    
    def load_sentences
      @sentences = []
    end
  
end
