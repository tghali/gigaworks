
# Inside ActionController::Integration::Session

# def generic_url_rewriter
#   env = {
#     'REQUEST_METHOD' => "GET",
#     'QUERY_STRING'   => "",
#     "REQUEST_URI"    => "/",
#     "HTTP_HOST"      => host,
#     "SERVER_PORT"    => https? ? "443" : "80",
#     "HTTPS"          => https? ? "on" : "off"
#   }
#   UrlRewriter.new(Request.new(env), {})
# end

# World(UrlHelper)