class Glossary::GlossaryController < ApplicationController
  
  def index
    @sentences = Sentence.limit(100).all
  end
  
  
  protected

    def load_words
      if params[:language]
        @words = Word.where(:language => params[:language].to_sym).limit(100)
      else
        @words = Word.limit(100).all
      end
    end
    
    def load_sentences
      @sentences = Sentence.limit(100).all
    end
  
end
