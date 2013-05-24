# encoding: UTF-8
class ChangeIcNamesAndSicNames < ActiveRecord::Migration
  def up
    industry_categories = IndustryCategory.unscoped
    industry_categories.each do |industry_category|
      case industry_category.name
        when "Argollas"
  				industry_category.update_attributes(:name => "argollas")
        when "Ajuar"
  				industry_category.update_attributes(:name => "ajuar")
        when "Peinado y maquillaje"
  				industry_category.update_attributes(:name => "peinado_y_maquillaje")
        when "Salud y estética"
  				industry_category.update_attributes(:name => "salud_y_estetica")
        when "Tocados y accesorios novia"
  				industry_category.update_attributes(:name => "tocados_y_accesorios_novia")
        when "Vestidos y calzado novia"
  				industry_category.update_attributes(:name => "vestidos_y_calzado_novia")
        when "Trajes y accesorios novio"
  				industry_category.update_attributes(:name => "trajes_y_accesorios_novio")
        when "Partes y detalles"
  				industry_category.update_attributes(:name => "partes_y_detalles")
        when "Centro de eventos"
  				industry_category.update_attributes(:name => "centro_de_eventos")
        when "Banqueteras"
  				industry_category.update_attributes(:name => "banqueteras")
        when "Coros"
  				industry_category.update_attributes(:name => "coros")
        when "Florerías"
  				industry_category.update_attributes(:name => "florerias")
        when "DJ y música"
  				industry_category.update_attributes(:name => "dj_y_musica")
        when "Fotografía y vídeo"
  				industry_category.update_attributes(:name => "fotografia_y_video")
        when "Cotillón"
  				industry_category.update_attributes(:name => "cotillon")
        when "Entretención y fiesta"
  				industry_category.update_attributes(:name => "entretencion_y_fiesta")
        when "Vinos y licores"
  				industry_category.update_attributes(:name => "vinos_y_licores")
        when "Iluminación y decoración"
  				industry_category.update_attributes(:name => "iluminacion_y_decoracion")
        when "Carpas y baños"
  				industry_category.update_attributes(:name => "carpas_y_baños")
        when "Hoteles"
  				industry_category.update_attributes(:name => "hoteles")
        when "Transporte"
  				industry_category.update_attributes(:name => "transporte")
        when "Carritos"
  				industry_category.update_attributes(:name => "carritos")
        when "Música en vivo"
  				industry_category.update_attributes(:name => "musica_en_vivo")
        when "Clases"
  				industry_category.update_attributes(:name => "clases")
        when "Vestidos de fiesta"
  				industry_category.update_attributes(:name => "vestidos_de_fiesta")
        when "Corredoras e Inmobiliarias"
  				industry_category.update_attributes(:name => "corredoras_e_inmobiliarias")
  		end
	  end
    sub_industry_categories = SubIndustryCategory.all
    sub_industry_categories.each do |sub_industry_category|
      case sub_industry_category.name
        when "Transporte para Novios"
					sub_industry_category.update_attributes(:name => "transporte_para_novios")
        when "Transporte para Invitados (conductores)"
					sub_industry_category.update_attributes(:name => "transporte_para_invitados_conductores")
        when "Vestidos de Novia"
					sub_industry_category.update_attributes(:name => "vestidos_de_novia")
        when "Zapatos de Novia"
					sub_industry_category.update_attributes(:name => "zapatos_de_novia")
        when "Banqueteras"
					sub_industry_category.update_attributes(:name => "banqueteras")
        when "Tortas y Cupcakes"
					sub_industry_category.update_attributes(:name => "tortas_y_cupcakes")
        when "Ambientación y Decoración"
					sub_industry_category.update_attributes(:name => "ambientacion_y_decoracion")
        when "Centro de eventos"
					sub_industry_category.update_attributes(:name => "centro_de_eventos")
        when "Complementos"
					sub_industry_category.update_attributes(:name => "complementos")
      end
    end
  end

  def down
    industry_categories = IndustryCategory.unscoped
    industry_categories.each do |industry_category|
      case industry_category.name
        when "argollas"
  				industry_category.update_attributes(:name => "Argollas")
        when "ajuar"
  				industry_category.update_attributes(:name => "Ajuar")
        when "peinado_y_maquillaje"
  				industry_category.update_attributes(:name => "Peinado y maquillaje")
        when "salud_y_estetica"
  				industry_category.update_attributes(:name => "Salud y estética")
        when "tocados_y_accesorios_novia"
  				industry_category.update_attributes(:name => "Tocados y accesorios novia")
        when "vestidos_y_calzado_novia"
  				industry_category.update_attributes(:name => "Vestidos y calzado novia")
        when "trajes_y_accesorios_novio"
  				industry_category.update_attributes(:name => "Trajes y accesorios novio")
        when "partes_y_detalles"
  				industry_category.update_attributes(:name => "Partes y detalles")
        when "centro_de_eventos"
  				industry_category.update_attributes(:name => "Centro de eventos")
        when "banqueteras"
  				industry_category.update_attributes(:name => "Banqueteras")
        when "coros"
  				industry_category.update_attributes(:name => "Coros")
        when "florerias"
  				industry_category.update_attributes(:name => "Florerías")
        when "dj_y_musica"
  				industry_category.update_attributes(:name => "DJ y música")
        when "fotografia_y_video"
  				industry_category.update_attributes(:name => "Fotografía y vídeo")
        when "cotillon"
  				industry_category.update_attributes(:name => "Cotillón")
        when "entretencion_y_fiesta"
  				industry_category.update_attributes(:name => "Entretención y fiesta")
        when "vinos_y_licores"
  				industry_category.update_attributes(:name => "Vinos y licores")
        when "iluminacion_y_decoracion"
  				industry_category.update_attributes(:name => "Iluminación y decoración")
        when "carpas_y_baños"
  				industry_category.update_attributes(:name => "Carpas y baños")
        when "hoteles"
  				industry_category.update_attributes(:name => "Hoteles")
        when "transporte"
  				industry_category.update_attributes(:name => "Transporte")
        when "carritos"
  				industry_category.update_attributes(:name => "Carritos")
        when "musica_en_vivo"
  				industry_category.update_attributes(:name => "Música en vivo")
        when "clases"
  				industry_category.update_attributes(:name => "Clases")
        when "vestidos_de_fiesta"
  				industry_category.update_attributes(:name => "Vestidos de fiesta")
        when "corredoras_e_inmobiliarias"
  				industry_category.update_attributes(:name => "Corredoras e Inmobiliarias")
  		end
	  end
    sub_industry_categories = SubIndustryCategory.all
    sub_industry_categories.each do |sub_industry_category|
      case sub_industry_category.name
        when "transporte_para_novios"
					sub_industry_category.update_attributes(:name => "Transporte para Novios")
        when "transporte_para_invitados_conductores"
					sub_industry_category.update_attributes(:name => "Transporte para Invitados (conductores)")
        when "vestidos_de_novia"
					sub_industry_category.update_attributes(:name => "Vestidos de Novia")
        when "zapatos_de_novia"
					sub_industry_category.update_attributes(:name => "Zapatos de Novia")
        when "banqueteras"
					sub_industry_category.update_attributes(:name => "Banqueteras")
        when "tortas_y_cupcakes"
					sub_industry_category.update_attributes(:name => "Tortas y Cupcakes")
        when "ambientacion_y_decoracion"
					sub_industry_category.update_attributes(:name => "Ambientación y Decoración")
        when "centro_de_eventos"
					sub_industry_category.update_attributes(:name => "Centro de eventos")
        when "complementos"
					sub_industry_category.update_attributes(:name => "Complementos")
      end
    end
  end

end


