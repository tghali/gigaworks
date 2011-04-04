module UrlHelper
  
  def host_with_subdomain(subdomain = nil, port = nil)
    subdomain << '.' if subdomain
    host = [subdomain, default_url_options[:host]]
    if port || (port = default_url_options[:port])
      host << ":#{port}"
    end
    host.join
  end
  
  def url_for(options = nil)
    if options.kind_of?(Hash) && options.has_key?(:subdomain)
      options[:host] = host_with_subdomain(options.delete(:subdomain), options.delete(:port))
      options[:only_path] = false
      
    end
    super options
  end
  
end
