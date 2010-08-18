unless ENV['RACK_ENV'] == 'production'
  begin
    YAML.load_file(File.expand_path('secrets.yml', File.dirname(__FILE__))).each do |key, value|
      ENV[key] = value
    end

  rescue
    raise "Error loading secrets configuration, please edit config/secrets.yml"
  end
end