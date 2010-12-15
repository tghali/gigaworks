Given /^an S3 destination for ([^\"]*)$/ do |model|
  # Regexp that matches the S3 destination
  path = "http://s3.amazonaws.com/*/#{model}/*/:size.:ext"
  
  Fredo.put path do
    [200, {}, 'OK']
  end
  
  Fredo.get path do
    fixture_path = File.expand_path("../../support/s3/placeholder_#{params[:size]}.#{params[:ext]}", __FILE__)
    [200, {'ContentType' => "image/#{params[:ext]}"}, File.read]
  end
end


When /^I attach "([^\"]*)" to the "([^\"]*)" file field on S3$/ do |filename, field|
  # Mock S3 response, shouldn't be done inside paperclip?  
  type = filename.split(".")[1]
  case type
  when "jpg" then mime = "image/jpeg"
  when "jpeg" then mime = "image/jpeg"
  when "mov" then mime = "video/quicktime"
  else mime = "text/plain"
  end

  attach_file field, File.join(RAILS_ROOT, "test/fixtures/files", filename), mime
end
