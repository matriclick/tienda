# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.matriclick.com"

SitemapGenerator::Sitemap.create do
  
  add '/chile', :changefreq => 'daily', :priority => 1
    
  Dress.all.each do |dress|
    add dress_ver_path(:type => dress.type, :slug => dress.slug, :country_url_path => 'chile'), :lastmod => dress.updated_at, :priority => 0.9
  end
  
  Post.find_each do |post|
    add post_path(post, :country_url_path => post.country.url_path), :lastmod => post.updated_at, :priority => 0.6
  end

end

#SEO: ping a buscadores
SitemapGenerator::Sitemap.ping_search_engines
