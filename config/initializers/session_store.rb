# Be sure to restart your server when you modify this file.

Gigavine::Application.config.session_store :cookie_store, :key => '_gigaworks_session', :domain => :all

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Gigavine::Application.config.session_store :active_record_store
