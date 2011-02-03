module Glossary::GlossaryHelper
  
  def language_flag_for entry
    %Q{<span class="iso639-1"><span class="flag #{entry.language}">#{entry.language}</span></span>}.html_safe
  rescue NoMethodError
    "no-lang".html_safe
  end
  
end
