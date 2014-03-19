# encoding: UTF-8
class DressesController < ApplicationController
  around_filter :catch_not_found
  before_filter :check_order, only: [:view, :view_search, :clearing]
  require 'will_paginate/array'
  
  # GET /dresses
  # GET /dresses.json
  def index 
    if !params[:type].nil?
      redirect_to dresses_ver_path :type => params[:type]
    else
      redirect_to bazar_path
    end
  end
  
  def refund_policy
    render :layout => false    
  end
  
  def faq_elbazar
    @title_content = 'Preguntas frecuentes'
    @meta_description_content = 'Preguntas frecuentes de la tienda online de vestidos y ropa de mujer'
    @background = true
    add_breadcrumb "El Bazar", :bazar_path
    add_breadcrumb "Preguntas frecuentes", :faq_elbazar_path
  end
  
  def contact_elbazar
    add_breadcrumb "Tramanta", :bazar_path
    add_breadcrumb "Contacto", :contact_elbazar_path
    
    @title_content = 'Formulario de Contacto'
    @meta_description_content = 'Contáctanos para resolver cualquier duda que tengas'
    @contact = Contact.new

    respond_to do |format|
      format.html
      format.json { render json: @contact }
    end
    
  end
    	
	def bazar
	  @home = true
    @not_breadcrumbs = true
    @home_categories = @site_configuration.home_categories.order 'position'
        
    @title_content = '¡Bienvenido!'
    @search_text = 'Busca por color, talla, tela, etc...'
    @subscriber = Subscriber.new
    @meta_description_content = 'Compra miles de productos de moda para la mujer: vestidos de fiesta, blusas, chaquetas, accesorios y muchas cosas más!'
	  if !current_supplier.nil?
	    sign_out current_supplier
    end
    add_breadcrumb "Tramanta", :bazar_path
  end

  def supplier_view
    #Solo entra acá si es un proveedor el que está mirando vestidos, así lo deja editar
    if current_supplier.nil?
      respond_to do |format|
        format.html { redirect_to bazar_path }
        format.json { head :ok }
      end
    else
      @search_term = params[:q]
      @search_text = @search_term != '' ? @search_term : 'Busca por color, talla, tela, etc...'
      set_supplier_layout
      
      @enable_edit = true
      @supplier = current_supplier
      @all_dresses = @supplier.supplier_account.dresses_filtered(@search_term)
      @dresses = @all_dresses.paginate(:page => params[:page]).order('created_at DESC')
      @dress_types = DressType.get_options(@supplier.supplier_account)
      @sizes = Dress.check_sizes(@all_dresses)
      
      @title_content = @dresses.size.to_s+' productos'

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @dresses }
      end
    end
  end
  
  def view
    @dress_types = DressType.where('name like "%'+params[:type]+'%"')
    generate_bread_crumbs(params[:type])
    @search_text = 'Busca por color, talla, tela, etc...'
        
    if @dress_types.size == 0
      respond_to do |format|
        format.html { redirect_to bazar_path }
        format.json { head :ok }
      end
    else
      disp = DressStatus.find_by_name("Disponible").id
      vend = DressStatus.find_by_name("Vendido").id
      @all_dresses = Dress.joins(:dress_types).where('dress_types.name like "%'+params[:type]+'%" and (dress_status_id = ? or dress_status_id = ?)', disp, vend)
      @dresses = @all_dresses.paginate(:page => params[:page]).order(@order)
      @sizes = Dress.check_sizes(@all_dresses)
      @title_content = (params[:type]).gsub('-', ' ').capitalize
    	@meta_description_content = 'Compra '+(params[:type]).gsub('-', ' ')
    end    
  end
  
  def view_search
    @search_term = params[:q]
    @search_sizes = params[:sizes]
    @clearing = params[:clearing]
    add_breadcrumb "Tramanta", :bazar_path    
      
    unless @search_term.blank? and @search_sizes.blank?
      @search_text = !@search_term.blank? ? @search_term.gsub('-', ' ').capitalize : 'Busca por color, talla, tela, etc...'
      if @clearing
        @all_dresses = Dress.all_filtered(@search_term, nil, 9).uniq
        @dresses = Dress.all_filtered(@search_term, @search_sizes, 9).order(@order).uniq.paginate(:page => params[:page])        
        add_breadcrumb 'Liquidación!', dresses_clearing_path
      else
        @all_dresses = Dress.all_filtered(@search_term).uniq
        @dresses = Dress.all_filtered(@search_term, @search_sizes).order(@order).uniq.paginate(:page => params[:page])
      end
      @sizes = Dress.check_sizes(@all_dresses)

      if !@search_term.nil?
        @title_content = 'Buscando '+@search_text
      	@meta_description_content = 'Compra '+@search_text
        add_breadcrumb @search_text, dresses_search_path(q: @search_text)
      else
        txt = @search_sizes.join(", ")  
        @title_content = 'Buscando por tallas: '+txt
      	@meta_description_content = 'Compra productos de moda en distintas tallas: '+txt
        add_breadcrumb 'Talla '+txt, dresses_search_path(sizes: @search_sizes)
      end
      
      render :view
    else
      respond_to do |format|
        format.html { redirect_to bazar_path }
        format.json { head :ok }
      end
    end
  end
  
  def new_arrivals
    disp = DressStatus.find_by_name("Disponible").id
    @all_dresses = Dress.where('dress_status_id = ?', disp).order('created_at DESC').limit(28)
    
    @order_param = params[:order]
    if !@order_param.nil? and @order_param != "- Orden -"
      if @order_param == "Precio Menor a Mayor"
        @dresses = @all_dresses.sort_by { |d| d.price }
      elsif @order_param == "Precio Mayor a Menor"
        @dresses = @all_dresses.sort_by { |d| -d.price }
      else
        @dresses = @all_dresses
      end
    else
      @dresses = @all_dresses
    end
    
    @sizes = Dress.check_sizes(@all_dresses)
    @not_paginate = true
    
    add_breadcrumb "Tramanta", :bazar_path
    add_breadcrumb 'New Arrivals!', dresses_new_arrivals_path
    @search_text = 'Busca por color, talla, tela, etc...'
    @title_content = 'New Arrivals'
  	@meta_description_content = 'Los últimos productos agregados: vestidos, leggings, blusas, chaquetas y muchas cosas más.'
    
    render :view
  end
  
  def clearing
    disp = DressStatus.find_by_name("Disponible").id
    @all_dresses = Dress.where('dress_status_id = ?', disp).where('discount > 9')
    @dresses = @all_dresses.paginate(:page => params[:page]).order(@order)
    @sizes = Dress.check_sizes(@all_dresses)
    
    add_breadcrumb "Tramanta", :bazar_path
    add_breadcrumb 'Liquidación!', :dresses_clearing_path
    @search_text = 'Busca por color, talla, tela, etc...'
    @title_content = 'Productos en Liquidación!'
  	@meta_description_content = 'Productos en liquidación: vestidos, leggings, blusas, chaquetas y muchas cosas más.'
    
    render :view
  end
  
  # GET /dresses/1
  # GET /dresses/1.json
  def show
    @enable_edit = false
    @admin = false
    
    @dress = Dress.find_by_slug(params[:slug])
    @type = DressType.find_by_name params[:type]
    @dress_stock_change_notification = DressStockChangeNotification.new
    
    if !@dress.nil? and !@type.nil?
      @related_dresses = @dress.get_related_dresses
      set_dresses_viewed_cookies(@dress)
      @viewed_dresses = get_dresses_viewed(@dress)
      @dress_stock_text = DressStockSize.where('dress_id = ? and stock > 0', @dress.id).map { |s| '<li>'+s.size.name+((!s.color.nil? and s.color != "") ? ' - '+s.color : '') if s.stock > 0 }.join('</li>')

      if @dress.supplier_account.nil? or @dress.dress_images.first.nil?
        respond_to do |format|
          format.html { redirect_to bazar_path }
          format.json { head :ok }
        end
      else 
        if !current_supplier.nil?
          set_supplier_layout
          @supplier = current_supplier
          @supplier_account = current_supplier.supplier_account
          @enable_edit = true
        elsif !current_user.nil? and current_user.role_id == 1 and !@dress.supplier_account.nil?
          @supplier_account = @dress.supplier_account
          @supplier = @supplier_account.supplier
          @enable_edit = true
          @admin = true
        end
    
        @soldable = (@type.name == 'vestidos-novia' ? true : false)
      
        @title_content = @dress.introduction
      	@meta_description_content = @type.name.gsub('-', ' ').capitalize+': '+@dress.description+' - '+@dress.description
        @og_type = 'article'
        @og_image = 'http://www.tramanta.com'+@dress.dress_images.first.dress.url(:original)
        @og_description = @type.name + ': ' + @dress.description

        @title = params[:type]
        generate_bread_crumbs(params[:type])
			  
        if !@dress.discount.blank? and @dress.discount > 9
          add_breadcrumb 'Liquidación!', :dresses_clearing_path
        end
        add_breadcrumb @dress.introduction.capitalize, dress_ver_path(:type => params[:type], :slug => params[:slug])
      
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @dress }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to bazar_path }
        format.json { head :ok }
      end      
    end
  end

  # GET /dresses/new
  # GET /dresses/new.json
  def new
    @dress = Dress.new
    
    if !current_supplier.nil?
      @supplier_account = current_supplier.supplier_account
      @supplier = @supplier_account.supplier
      @dress.supplier_account = @supplier_account
      set_supplier_layout
      @dress_types = DressType.all
      @colors = Color.all

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @dress }
      end
    else
      redirect_to bazar_path, notice: 'Solo puedes crear productos entrando como proveedor.'
    end
  end

  # GET /dresses/1/edit
  def edit            
    @dress = Dress.find(params[:id])
    @dress_types = DressType.all
    @colors = Color.all
    @supplier_account =  @dress.supplier_account
    @supplier =  @dress.supplier_account.supplier
    
    if !current_supplier.nil?
      set_supplier_layout
    end
  end

  # POST /dresses
  # POST /dresses.json
  def create
    @dress = Dress.new(params[:dress])
    @supplier_account = SupplierAccount.find params[:dress][:supplier_account_id]
    
    respond_to do |format|
      if @dress.save
        format.html { redirect_to dresses_set_stock_path(id: @dress) }
        format.json { render json: @dress, status: :created, location: @dress }
      else
        format.html { render action: "new" }
        format.json { render json: @dress.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_stock
    if !current_supplier.nil?
      @supplier_account = current_supplier.supplier_account
      @supplier = @supplier_account.supplier
      set_supplier_layout
    end
    
    @dress = Dress.find(params[:id])
    @sizes = @dress.dress_types.first.sizes
  end
  
  # PUT /dresses/1
  # PUT /dresses/1.json
  def update
    @dress = Dress.find(params[:id])
    @dress_types = DressType.all
    
    @stock_updated = (params[:commit] == 'Guardar')
    
    respond_to do |format|
      if @dress.update_attributes(params[:dress])
        if !@stock_updated
          format.html { redirect_to dresses_set_stock_path(id: @dress) }
          format.json { head :ok }
        else
          send_email_to_people_interested_in_dress(@dress)
          format.html { redirect_to dress_ver_path(type: @dress.dress_types.first.name, slug: @dress.slug) }
          format.json { head :ok }        
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @dress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dresses/1
  # DELETE /dresses/1.json
  def destroy
    @dress = Dress.find(params[:id])
    @dress.destroy

    respond_to do |format|
      format.html { redirect_to bazar_path }
      format.json { head :ok }
    end
  end

  def dress_request
		@dress = Dress.find_by_slug params[:slug]
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
	def notify_request
		@dress = Dress.find_by_slug params[:slug]
		@user = current_user
		@dress_url = dress_ver_url(:type => @dress.dress_types.first.name, :slug => @dress.slug)
		
		@dress_request = DressRequest.new(:dress_id => @dress.id, :user_id => @user.id)
		@dress_request.save
		
		if @dress.present? and @user.present?
			UserMailer.dress_request_to_seller_email(@dress, @user, @dress_url).deliver
			UserMailer.dress_request_to_buyer_email(@dress, @user, @dress_url).deliver
		end
		
		redirect_to dress_ver_path(:type => @dress.dress_types.first.name, :slug => @dress.slug), :notice => 'Hemos enviado los datos de contacto al correo'
	end
	
  def display_dispatch_costs
    @regions = []
    @regions << Region.find_by_name('RM - Metropolitana')
    @regions = @regions + Region.all
    @regions = @regions.uniq
    render :layout => false
  end
  
  private
  
  def check_order
    @order_param = params[:order]
    if @order_param.nil? or @order_param == "- Orden -"
      if action_name == 'new_arrivals'
        @order = "updated_at DESC"
      else
        @order = "created_at DESC, position ASC"
      end
    else
      if @order_param == "Lo nuevo"
        @order = "created_at DESC"
      elsif @order_param == "Precio Menor a Mayor"
        @order = "price ASC"
      elsif @order_param == "Precio Mayor a Menor"
        @order = "price DESC"
      end
    end
  end

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :error => "No encontramos lo que estabas buscando" }
  end
  
  def generate_bread_crumbs(dress_type_param)
    add_breadcrumb "Tramanta", :bazar_path
    add_breadcrumb dress_type_param.gsub('-', ' ').capitalize, dresses_ver_path(:type => dress_type_param)
  end
  
  def set_dresses_viewed_cookies(dress)
    if cookies[:viewed_dresses_ids].nil?
      cookies[:viewed_dresses_ids] = { :value => dress.id.to_s, :expires => 2.month.from_now }
    else
      cookies[:viewed_dresses_ids] = { :value => dress.id.to_s+','+cookies[:viewed_dresses_ids], :expires => 2.month.from_now }
    end
  end
  
  def get_dresses_viewed(dress = nil)
    if !cookies[:viewed_dresses_ids].nil?
      ids = cookies[:viewed_dresses_ids].split(',')
      ids.delete(dress.id.to_s)
      ids.uniq!
      dresses = Array.new
      length = ids.size > 3 ? 3 : ids.size
      ids[0..length].each do |id|
        dress = Dress.find_by_id id
        if !dress.nil?
          dresses.push(dress)
        end
      end
      return dresses
    end
  end    
  
  def send_email_to_people_interested_in_dress(dress)
    dress.dress_stock_change_notifications.each do |dscn|
      if dress.sizes.where('size_id = ? and stock > 0', dscn.size_id).size > 0
        NoticeMailer.dress_stock_change_notification_email(dscn).deliver
      end
    end
  end
  
end
