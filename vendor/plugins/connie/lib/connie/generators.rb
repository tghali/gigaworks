module Connie

  if defined? Rails && (Rails.version.to_f >= 3.0)
    class DictionaryGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)
    end
  end
  
end