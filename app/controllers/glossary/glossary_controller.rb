class Glossary::GlossaryController < ApplicationController
  
  def index
    @sentences = Sentence.all
  end
  
  
  protected

    def load_words
      if params[:language]
        @words = Word.where(:language => params[:language].to_sym)
      else
        @words = Word.all
      end
    end
    
    def load_sentences
      @sentences = Sentence.all
    end
  
end
