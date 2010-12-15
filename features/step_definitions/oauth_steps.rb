Given /^a (\w*) account(?: with #{capture_fields})? is authorized$/ do |provider, fields|
  Fredo.oauth(provider, fields)
end
