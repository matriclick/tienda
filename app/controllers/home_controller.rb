# encoding: UTF-8
class HomeController < ApplicationController
	before_filter :load_user_tools_menu, :except => [:check_country, :chile, :peru, :tour, :subscription_create, :subscription]
	before_filter :hide_left_menu, :except => [:check_country, :chile, :peru, :index, :wedding_tools]

	def test_home
	  @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => 1).order(:position)
  	@title_content = 'Matrimonios | Centros de Eventos y Casonas | Vestuario Femenino y de Bebe | Viajes | Vivienda y Decoración'
  	@meta_description_content = 'Todo lo que necesitas desde que decides casarte: te ayudamos a organizar tu matrimonio, comprar ropa de fiesta, organizar tu casa, irte de luna de miel y comprar ropa para el primer integrante de la familia'	  
  	
  	dress_type_fiesta = DressType.find_by_name('vestidos-fiesta')
  	@dresses = dress_type_fiesta.dresses.available.order('position').limit 5
  	@casonas = Post.where(:country_id => session[:country].id, :post_type => 'Pack').is_visible.order('created_at DESC').limit 3
  	@viajes = Post.where(:country_id => session[:country].id, :post_type => 'Lunas de Miel').is_visible.order('created_at DESC').limit 3
  	#dress_type_muebles = DressType.find_by_name('tu-casa-living-mesas')
  	#@productos = dress_type_muebles.dresses.available.order('position').limit 5
  	#dress_type_bebe = DressType.find_by_name('ropa-bebe-niño')
  	#@ropa_bebes = dress_type_bebe.dresses.available.order('position').limit 5
    @nombre_imagenes_tu_casa = ['tu-casa-living', 'tu-casa-cocina', 'tu-casa-comedor']
    @nombre_imagenes_mi_bebe = ['ropa-de-bebe']
    
    @subscriber = Subscriber.new
    @subscriber_preferences = SubscriberPreference.all
	end

	def index
	  redirect_to root_country_path
	end
	
	def check_country
	  @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => 1).order(:position)
  	@title_content = 'Matrimonios | Centros de Eventos y Casonas | Vestuario Femenino y de Bebe | Viajes | Vivienda y Decoración'
  	@meta_description_content = 'Todo lo que necesitas desde que decides casarte: te ayudamos a organizar tu matrimonio, comprar ropa de fiesta, organizar tu casa, irte de luna de miel y comprar ropa para el primer integrante de la familia'	  
  	
  	dress_type_fiesta = DressType.find_by_name('vestidos-fiesta')
  	@dresses = dress_type_fiesta.dresses.available.order('position').limit 5
  	@casonas = Post.where(:country_id => session[:country].id, :post_type => 'Pack').is_visible.order('created_at DESC').limit 3
  	@viajes = Post.where(:country_id => session[:country].id, :post_type => 'Lunas de Miel').is_visible.order('created_at DESC').limit 3
  	#dress_type_muebles = DressType.find_by_name('tu-casa-living-mesas')
  	#@productos = dress_type_muebles.dresses.available.order('position').limit 5
  	#dress_type_bebe = DressType.find_by_name('ropa-bebe-niño')
  	#@ropa_bebes = dress_type_bebe.dresses.available.order('position').limit 5
    @nombre_imagenes_tu_casa = ['tu-casa-living', 'tu-casa-cocina', 'tu-casa-comedor']
    @nombre_imagenes_mi_bebe = ['ropa-de-bebe']
    
    @subscriber = Subscriber.new
    @subscriber_preferences = SubscriberPreference.all  	  	
  end
	
	def subscription
    @subscriber = Subscriber.new
    @title_content = 'Subscribirse a Tramanta.com'
  	@meta_description_content = 'Suscríbete a Tramanta.com para recibir toda la información sobre moda y tendencias'  	
  	
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @subscriber }
    end
  end
  
  def subscription_create
    @subscriber = Subscriber.new(params[:subscriber])
    @subscriber.subscriber_preferences << SubscriberPreference.find_by_name("El Bazar")
    
    respond_to do |format|
      if @subscriber.save
        format.html { redirect_to session[:url_coming_from], notice: '¡Genial! Ya estás inscrito' }
        format.json { render json: @subscriber, status: :created, location: @subscriber }
      else
        format.html { render action: "subscription" }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
	def terms
	  add_breadcrumb "Tramanta", :bazar_path
	  add_breadcrumb "Condiciones de Uso", :terms_path
	  
	  @title_content = 'Condiciones de Uso'    
	  @meta_description_content = "Estas son las condiciones de uso de Matriclick."
      respond_to do |format| 
      	format.html # terms.html.erb
      end  
	end
	
	def company
	  add_breadcrumb "Tramanta", :bazar_path
	  add_breadcrumb "Quiénes Somos", :company_path
	  
  	@title_content = 'Quiénes Somos'
	  @meta_description_content = "Somos una empresa joven, compuesta por un equipo multi-disciplinario de ingenieros, publicistas, diseñadores y periodistas."
	  respond_to do |format| 
      format.html # company.html.erb
    end  
	end
	
	def faq
  	@title_content = 'Preguntas Frecuentes de la Empresa'
  	@meta_description_content = 'Información sobre la creación y orígenes de Matriclick.com'
	  respond_to do |format| 
      format.html # faq.html.erb
    end  
	end
	
	def criteria
	  respond_to do |format| 
      format.html # criteria.html.erb
    end  
	end
	
	def como_nace
  	@title_content = 'Creación y Origen de Matriclick.com'
  	@meta_description_content = 'Información sobre la creación y orígenes de Matriclick.com'
	  respond_to do |format| 
      format.html # como_nace.html.erb
    end  
	end
	
	def press
	  add_breadcrumb "Tramanta", :bazar_path
	  add_breadcrumb "Prensa", :press_path
	  
	  @title_content = 'Prensa' 
	  @meta_description_content = "Revisa las numerosas apariciones en prensa que ha tenido Matriclick: Canal 13, Chilevisión, Emol, Terra, La Segunda, Radio Agricultura, 24 horas, La Nación"
    respond_to do |format| 
      format.html # press.html.erb
    end  
	end
	
	def work_with_us
	  add_breadcrumb "Tramanta", :bazar_path
	  add_breadcrumb "Trabaja con nosotros", :work_with_us_path
	  
  	@title_content = 'Postulación a Trabajos'
  	@meta_description_content = 'Postula y trabaja con nosotros'

	  respond_to do |format| 
      format.html # work_with_us.html.erb
    end  
	end
	
	private
	def hide_left_menu
	 @hide_left_menu = true
	end
end
