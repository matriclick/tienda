# encoding: UTF-8
class TravelController < ApplicationController
  add_breadcrumb "Viajes", :travel_path
  #Ver ideas en http://www.mandalaviajes.cl/viajes/tipos-de-viaje/luna-de-miel/
  def index
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'Viajes').is_visible.order('created_at DESC')
    
    matri_packs_type = SliderImageType.find_by_name('Viajes')
    if !matri_packs_type.nil?
      @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => matri_packs_type.id).order(:position)
    else
      @slider_images = []
    end
	  
  	@title_content = 'Destinos para tus vacaciones'
  	@meta_description_content = 'Destinos para tus vacaciones'
  	@h1 = 'Viajes Matriclick'
  	@h2 = 'Destinos para tus vacaciones'
  	@h3 = 'El que está acostumbrado a viajar, sabe que siempre es necesario partir algún día'

  end

  def paquetes
    find_destinations_by_address
    add_breadcrumb "Paquetes", :paquetes_path
  end
  
  def destino
    @object = find_product_or_service(params[:slug])
    if @object.nil?
      redirect_to paquetes_path
    else    
      @description = @object.description
      @supplier = @object.supplier_account.supplier
      @title_content = @supplier.supplier_account.fantasy_name+': '+@object.name+' | Descripción'
    	@meta_description_content = @supplier.supplier_account.fantasy_name+' | '+@object.name+': '+@object.description
    end
    add_breadcrumb "Destino", :destino_path
  end
  
  def caribe
    find_destinations_by_address('Caribe')
    add_breadcrumb "Caribe", :caribe_path
  end

  def sudeste
    find_destinations_by_address('Sudeste')  
    add_breadcrumb "Sudeste Asiático", :sudeste_path
  end

  def europa
    find_destinations_by_address('Europa')
    add_breadcrumb "Europa", :europa_path
  end
  
  private
  
  def find_destinations_by_address(address = false)
    ic = IndustryCategory.find_by_name("viajes")
    if !address
      @objects = Service.search(ic.id).alphabetized.approved
    else
      @objects = Service.search(ic.id).where("address like '%"+address+"%'").alphabetized.approved
    end
	  @objects_count = @objects.count
  end
  
end
