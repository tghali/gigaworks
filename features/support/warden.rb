include Warden::Test::Helpers

#  Teardown tests
#  include Warden::Test::Helpers
#  after{ Warden.test_reset! }
#  
#  Login
#  -----
#
#  setup the helpers by including them into your test scope 
#  
#  include Warden::Test::Helpers
# 
#  To login for the next action as "A User"
# 
#  login_as "A User" 
#  get "/foo" 
# 
#  To login for the next action as "An Admin" 
# 
#  login_as "An Admin", :scope => :admin 
#  get "/foo"
#  
#  Login both an admin and standard user 
# 
#  login_as "A User" 
#  login_as "An Admin", :scope => :admin 
#  get "/foo"
# 
#  Logout
#  ------
# 
#  setup the helpers 
#  include Warden::Test::Helpers 
# 
#  Logout all users _before_ your application receives the request
# 
#  logout 
#  get "/foo"
# 
#  Logout only the admin user before your application receives a 
#  result
# 
#   logout :admin 
#   get "/foo"