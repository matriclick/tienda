# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.matriclick.com"

SitemapGenerator::Sitemap.create do
    
  Post.find_each do |post|
    add post_path(post, :country_url_path => post.country.url_path), :lastmod => post.updated_at, :priority => 0.6
  end
  
  SupplierAccount.approved.each do |supplier_account|
    add supplier_products_and_services_path(supplier_account.supplier_id, :public_url => supplier_account.public_url, :country_url_path => supplier_account.country.url_path), :lastmod => supplier_account.updated_at
  end
  
  Product.approved.each do |element|
    add products_and_services_catalog_description_path(element.id, :object_class => element.class, :country_url_path => element.supplier_account.country.url_path), :lastmod => element.updated_at
  end
  
  Service.approved.each do |element|
    add products_and_services_catalog_description_path(element.id, :object_class => element.class, :country_url_path => element.supplier_account.country.url_path), :lastmod => element.updated_at
  end
end

#SEO: ping a buscadores
SitemapGenerator::Sitemap.ping_search_engines
