# encoding: UTF-8
class PacksController < ApplicationController
  before_filter :set_type_param
  
  def index
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'Pack').is_visible.order('created_at DESC')
    
    matri_packs_type = SliderImageType.find_by_name('Matri-packs')
    if !matri_packs_type.nil?
      @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => matri_packs_type.id).order(:position)
    else
      @slider_images = []
    end
	  
  	@title_content = 'Casonas y Centros de Eventos'
  	@meta_description_content = 'Casonas y Centros de Eventos para realizar tu Matrimonio con el estilo que quieras'
  	@h1 = 'Casonas y Centros de Eventos'
  	@h2 = 'Lugares perfectos para realizar tu matrimonio en los alrededores de Santiago'
  	@h3 = 'Para ceremonias y fiestas estilos campestres, modernos, vintage y todo lo que quieras imaginar.'
    add_breadcrumb "Casonas y Centros de Eventos", :casonas_matriclick_path
  
  	respond_to do |format|
      format.html { render :casonas }
      format.json { render json: @posts }
    end
  end
  
  def honey_moons
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'Lunas de Miel').is_visible.order('created_at DESC')
    
    matri_packs_type = SliderImageType.find_by_name('Lunas de Miel')
    if !matri_packs_type.nil?
      @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => matri_packs_type.id).order(:position)
    else
      @slider_images = []
    end
	  
  	@title_content = 'Lunas de Miel'
  	@meta_description_content = 'Ideas, historias y muchas otras cosas más para planificar tu Luna de Miel soñada'
  	@h1 = 'Lunas de Miel'
  	@h2 = 'Ideas de viajes y recorridos para realizar tu luna de miel'
  	@h3 = 'Tailandia, Europa, El Caribe, Estados Unidos... los datos que necesitas para tener la luna de miel que sueñas'
    add_breadcrumb "Blog Lunas de miel", :lunas_de_miel_path
      	
  	respond_to do |format|
      format.html { render :index }
      format.json { render json: @posts }
    end
  end
  
  def viajes
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'Viajes').is_visible.order('created_at DESC')
    
    matri_packs_type = SliderImageType.find_by_name('Viajes')
    if !matri_packs_type.nil?
      @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => matri_packs_type.id).order(:position)
    else
      @slider_images = []
    end
	  
  	@title_content = 'Viajes'
  	@meta_description_content = 'Ideas, historias y muchas otras cosas más para tus viajes'
  	@h1 = 'Viajes Matriclick'
  	@h2 = 'Grandes oportunidades para escaparse en un viaje de vacaciones a tu medida y a tu presupuesto'
  	@h3 = 'Tailandia, Europa, El Caribe, Estados Unidos... donde quieras ir te llevamos'
    add_breadcrumb "Blog Viajes", :blog_viajes_path
      	
  	respond_to do |format|
      format.html { render :index }
      format.json { render json: @posts }
    end
  	
  end
  
  def tu_casa
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'Tu Casa').is_visible.order('created_at DESC')
    
    matri_packs_type = SliderImageType.find_by_name('Tu Casa')
    if !matri_packs_type.nil?
      @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => matri_packs_type.id).order(:position)
    else
      @slider_images = []
    end
	  
  	@title_content = 'Muebles y artículos para el hogar | Tu Casa'
  	@meta_description_content = 'Muebles, artículos para el hogar y muchas cosas relacionadas con vivienda, decoración y diseño'
  	@h1 = 'Decoración y Vivienda'
  	@h2 = 'Tu Casa Matriclick te entrega ideas y datos para decorar y amoblar tu casa o departamento'
  	@h3 = 'Arma tu living, terraza, dormitorio, cocina y todos los espacios de tu hogar con todos estas ideas que tenemos preparadas para ti'
    add_breadcrumb "Blog Tu Casa", :blog_tu_casa_path
    
  	respond_to do |format|
      format.html { render :index }
      format.json { render json: @posts }
    end
  end
  
  def aguclick
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'Aguclick').is_visible.order('created_at DESC')
    
    matri_packs_type = SliderImageType.find_by_name('Aguclick')
    if !matri_packs_type.nil?
      @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => matri_packs_type.id).order(:position)
    else
      @slider_images = []
    end
	  
  	@title_content = 'Ropa de bebe y consejos para la crianza'
  	@meta_description_content = 'Vestuario para acompañar a tu bebe durante todo el proceso de crecimiento e ideas y consejos para apoyar la crianza del bebe'
  	@h1 = 'Título para ropa de bebe'
  	@h2 = 'Bajada para ropa de bebe más larga que el título'
  	@h3 = 'Introducción para ropa de bebe más larga que la bajada'
    add_breadcrumb "Blog Aguclick", :blog_aguclick_path
      	
  	respond_to do |format|
      format.html { render :index }
      format.json { render json: @posts }
    end
  end

  def el_bazar
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'El Bazar').is_visible.order('created_at DESC')
    
    matri_packs_type = SliderImageType.find_by_name('El Bazar')
    if !matri_packs_type.nil?
      @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => matri_packs_type.id).order(:position)
    else
      @slider_images = []
    end
	  
  	@title_content = 'Moda y Tendencias'
  	@meta_description_content = 'Reportajes e información sobre las últimas tendencias de la moda local e internacional'
  	@h1 = 'Título para El Bazar'
  	@h2 = 'Bajada para El Bazar más larga que el título'
  	@h3 = 'Introducción para El Bazar más larga que la bajada'
    add_breadcrumb "Blog El Bazar", :blog_el_bazar_path
      	
  	respond_to do |format|
      format.html { render :index }
      format.json { render json: @posts }
    end
  end
  
end
