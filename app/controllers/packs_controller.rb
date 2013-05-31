# encoding: UTF-8
class PacksController < ApplicationController
  before_filter :set_type_param
  
  def el_bazar
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'El Bazar').is_visible.order('created_at DESC')
    @background = true
    
    matri_packs_type = SliderImageType.find_by_name('El Bazar')
    if !matri_packs_type.nil?
      @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => matri_packs_type.id).order(:position)
    else
      @slider_images = []
    end
	  
  	@title_content = 'Moda y Tendencias'
  	@meta_description_content = 'Reportajes e información sobre las últimas tendencias de la moda local e internacional'
  	@h1 = 'Revista de Moda y Tendencias (por definir por Pili)'
  	@h2 = 'En este blog encontrarás datos, ideas y todo lo que necesitas saber para que te te sigan (por definir por Pili)'
  	@h3 = 'Alguna introducción para El Bazar más larga que la bajada (por definir por Pili)'
    add_breadcrumb "Blog El Bazar", :blog_el_bazar_path
      	
  	respond_to do |format|
      format.html { render :index }
      format.json { render json: @posts }
    end
  end
  
end
