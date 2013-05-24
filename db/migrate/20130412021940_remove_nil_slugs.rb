class RemoveNilSlugs < ActiveRecord::Migration
  def up
    ps = Product.all
    ps.each do |p|
      if p.slug.nil?
        aux = p.name.gsub(/\s*[^A-Za-z0-9\.\-]\s*/, '-').to_s + p.id.to_s
        puts aux
        p.update_attribute :slug, aux
      end
    end
    
    ss = Service.all
    ss.each do |s|
      if s.slug.nil?
        aux = s.name.gsub(/\s*[^A-Za-z0-9\.\-]\s*/, '-').to_s + s.id.to_s
        puts aux
        s.update_attribute :slug, aux
      end
    end
    
  end

  def down
  end
end
