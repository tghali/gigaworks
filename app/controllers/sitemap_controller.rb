class SitemapController < ActionController::Base
  def sitemap
    @entries = FrontendPage.find(:all, :order => "updated_at DESC", :limit => 50000)
    headers["Content-Type"] = "text/xml"
    # set last modified header to the date of the latest entry.
    render :layout => false
    #headers["Last-Modified"] = @entries[0].updated_at.httpdate
  end

end
