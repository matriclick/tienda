# encoding: UTF-8
class PacksController < ApplicationController
  before_filter :set_type_param
  
  def el_bazar
    @posts = Post.is_visible.order('created_at DESC')
    @background = true
	  
  	@title_content = 'Moda y Tendencias'
  	@meta_description_content = 'Reportajes e información sobre las últimas tendencias de la moda local e internacional'
  	@h1 = 'Revista de Moda y Tendencias'
  	@h2 = 'En este blog encontrarás datos, ideas y todo lo que necesitas saber para que todas te sigan'
  	@h3 = ''
    add_breadcrumb "Blog Tramanta", :blog_el_bazar_path
    	
  	respond_to do |format|
      format.html { render :index }
      format.json { render json: @posts }
    end
  end
  
end
