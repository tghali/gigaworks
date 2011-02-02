class Glossary::GlossaryController < ApplicationController
  
  before_filter :load_words
  
  def index
    @words = Word.all
  end
  
  
  protected

    def load_words
      if params[:language]
        @words = Word.where(:language => params[:language].to_sym)
      else
        @words = Word.all
      end
    end
  
end
