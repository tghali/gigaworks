unless ENV['HEROKU']
  Paperclip.options[:command_path] = "/usr/local/bin"
end
