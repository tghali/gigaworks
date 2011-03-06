module Glossary::GlossaryHelper
  
  def language_flag_for entry
    %Q{<span class="iso639-1"><span class="flag #{entry.language}">#{entry.language}</span></span>}.html_safe
  rescue NoMethodError
    "no-lang".html_safe
  end
  
  def flag_toggle_for sentence
    if can? :flag, sentence
      if sentence.flagged?
        link_to 'Unflag sentence', flag_glossary_sentence_path, :class => 'flag flagged', :method => :put
      else
        link_to 'Flag sentence', flag_glossary_sentence_path, :class => 'flag', :method => :put
      end
    else
      if sentence.flagged?
        content_tag(:em, "this sentence has been flagged", :class => 'flag')
      else
        content_tag(:em, "this sentence has not been flagged", :class => 'flag flagged')
      end
    end
  end
  
end
