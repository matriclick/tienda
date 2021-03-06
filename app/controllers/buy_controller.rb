# encoding: UTF-8
require "active_merchant/billing/integrations/action_view_helper"
require "net/http"
class BuyController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :details, :confirm, :add_to_cart, :remove_from_cart, :view_cart, :refresh_cart]
  before_filter :get_order_and_log_user_back, :only => [:success, :failure]

  helper ActiveMerchant::Billing::Integrations::ActionViewHelper
  
  def index
    @user = current_user

    @oc = Order.new
    @oc.user = @user
    @oc.tbk_orden_compra = DateTime.current().to_s(:number) + 'U' + @user.id.to_s
    @oc.tbk_id_sesion = DateTime.current().to_s(:number) + 'U' + @user.id.to_s
    @oc.tbk_tipo_transaccion = 'TR_NORMAL'
  	@oc.tbk_monto = '50'
    @oc.save
  end

  #POST
  def add_to_cart
    user = current_user
    purchasable_id = params[:purchasable_id]
    purchasable_type = params[:purchasable_type]
    color = params[:shopping_cart_item][:color] if !params[:shopping_cart_item].nil?
    size = params[:shopping_cart_item][:size] if !params[:shopping_cart_item].nil?
    shopping_cart = user.select_current_shopping_cart
    
    if !size.blank? and !DressStockSize.where(dress_id: purchasable_id, size_id: Size.find_by_name(size).id, color: color).first.nil?
      shopping_cart_item = 
        ShoppingCartItem.where(:purchasable_id => purchasable_id, :purchasable_type => purchasable_type, :shopping_cart_id => shopping_cart.id,
        :size => size, :color => color).first
    
      if shopping_cart_item.nil?
        shopping_cart_item = ShoppingCartItem.create(:purchasable_id => purchasable_id, :purchasable_type => purchasable_type, :shopping_cart_id => shopping_cart.id,
        :size => size, :color => color)
      end
    
      redirect_to buy_view_cart_path
    else
      @dress = Dress.find purchasable_id
      respond_to do |format|
        format.html { redirect_to dress_ver_path(type: @dress.dress_types.first.name, slug: @dress.slug), notice: 'La combinación talla/color que seleccionaste no está disponible' }
        format.json { head :ok }
      end
    end
  end
  
  #POST
  def remove_from_cart
    user = current_user
    shopping_cart = user.select_current_shopping_cart
    
    shopping_cart_item = ShoppingCartItem.find params[:shopping_cart_item_id]
    
    shopping_cart.shopping_cart_items.delete(shopping_cart_item)
    shopping_cart_item.destroy
    
    redirect_to buy_view_cart_path
  end
  
  #GET
  def view_cart
    user = current_user
    @shopping_cart = user.select_current_shopping_cart
    @shopping_cart_items = @shopping_cart.shopping_cart_items
    
    add_breadcrumb "Tramanta", :bazar_path
    add_breadcrumb "Carrito", :buy_view_cart_path
  end
  
  def refresh_cart
    user = current_user
    @shopping_cart = user.select_current_shopping_cart
    
    @shopping_cart_items = ShoppingCartItem.update(params[:shopping_cart_items].keys, params[:shopping_cart_items].values).reject { |shopping_cart_item| shopping_cart_item.errors.empty? }
    
    if @shopping_cart_items.empty?
      if params[:commit] == 'Pagar carrito de compras'
        if @shopping_cart.check_all_items_are_available
          redirect_to buy_details_path(:purchasable_type => @shopping_cart.class, :purchasable_id => @shopping_cart.id)
        else
          respond_to do |format|
            format.html { redirect_to buy_view_cart_path, notice: 'Tienes productos en tu carrito sin stock disponible<br /><br />Debes eliminarlos para continuar con el pago.' }
            format.json { head :ok }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to buy_view_cart_path, notice: 'No has agregado productos al carrito de compras' }
          format.json { head :ok }
        end
      end
    else
      render :action => "view_cart"
    end
  end
  
  def confirm
    @user = current_user
    @purchase = Purchase.find params[:purchase_id]
    @purchasable = @purchase.purchasable
    
    add_breadcrumb "Tramanta", :bazar_path
    add_breadcrumb "Carrito", :buy_view_cart_path
    
    if !@purchase.delivery_info.nil?
      @show_map = true
      @map = @purchase.delivery_info
    end
        
    if (@purchase.transfer_type == 'webpay') and @purchase.price > 0
      @oc = Order.new
      @oc.purchase = @purchase
      @oc.tbk_orden_compra = DateTime.current().to_s(:number) + 'U' + @user.id.to_s
      @oc.tbk_id_sesion = DateTime.current().to_s(:number) + 'U' + @user.id.to_s
      @oc.tbk_tipo_transaccion = 'TR_NORMAL'
    	@oc.tbk_monto = @purchase.price.to_s
      @oc.save
    end
    
  end

  def details
    @user = current_user
    @purchase = Purchase.new
    @purchasable = eval(params[:purchasable_type] + '.find ' + params[:purchasable_id])
    @subtotal = @purchasable.price
    
    add_breadcrumb "Tramanta", :bazar_path
    add_breadcrumb "Carrito", :buy_view_cart_path
    
    if params[:purchasable_type] == 'Dress'
      @stocks_for_js = '{'
      @purchasable.dress_stock_sizes.each do |dress_stock_size|
  			if !dress_stock_size.stock.blank?
  			  if dress_stock_size.stock > 0
  			    if dress_stock_size.first_with_stock?
  			      @first_max = dress_stock_size.stock
  		      end
            @stocks_for_js += 'purchase_size_' + dress_stock_size.size.name.downcase.gsub(" ","_").gsub("á","").gsub("é","").gsub("í","").gsub("ó","").gsub("ú","").gsub("Á","").gsub("É","").gsub("Í","").gsub("Ó","").gsub("Ú","") + ': ' + dress_stock_size.stock.to_s + ','
          end
        end
      end
      @stocks_for_js = @stocks_for_js[0..@stocks_for_js.size - 2] + '}'
    end
    
    if current_user.check_if_has_credits
      if @purchasable.price - current_user.credit_amount > 0
  			@price = @purchasable.price - current_user.credit_amount
  		else
  		  @price = 0
  		end
		else
		  @price = @purchasable.price
	  end
  end
  
  def notify
    notify = ActiveMerchant::Billing::Integrations::Webpay::Notification.new(request.raw_post)
 
    ocs = Order.where(:tbk_orden_compra => params['TBK_ORDEN_COMPRA'])
    if ocs.count == 1
      oc = ocs.first
      if oc.matri_result.nil?
        oc.update_attributes(
                            :tbk_respuesta => params['TBK_RESPUESTA'],
                            :tbk_codigo_autorizacion => params['TBK_CODIGO_AUTORIZACION'],
                            :tbk_final_numero_tarjeta => params['TBK_FINAL_NUMERO_TARJETA'],
                            :tbk_fecha_expiracion => params['TBK_FECHA_EXPIRACION'],
                            :tbk_fecha_contable => params['TBK_FECHA_CONTABLE'],
                            :tbk_fecha_transaccion => params['TBK_FECHA_TRANSACCION'],
                            :tbk_hora_transaccion => params['TBK_HORA_TRANSACCION'],
                            :tbk_id_transaccion => params['TBK_ID_TRANSACCION'],
                            :tbk_tipo_pago => params['TBK_TIPO_PAGO'],
                            :tbk_numero_cuotas => params['TBK_NUMERO_CUOTAS'],
                            :tbk_mac => params['TBK_MAC'],
                            :tbk_tasa_interes_max => params['TBK_TASA_INTERES_MAX']
                            )
      end
    end

    if params['TBK_RESPUESTA'] == '0'
      if notify.valid?
        if !oc.nil?
          if oc.matri_result.nil?
            if oc.tbk_monto.to_f == params['TBK_MONTO'].to_f / 100
              oc.update_attributes(:matri_result => 'Transaccion Exitosa')
            else
              oc.update_attributes(:matri_result => 'Monto no coincide')
              notify.fail! 'Monto no coincide'
            end
          else
            oc.update_attributes(:matri_result => oc.matri_result + ' | Orden ya utilizada')
            notify.fail! 'Orden ya utilizada'
          end
        else
          notify.fail! 'Orden duplicada o inexistente'
        end
      else
        if !oc.nil?
          oc.update_attributes(:matri_result => 'Mac Invalido')
          notify.fail! 'Mac Invalido'
        end
      end
    else
      if !oc.nil?
        oc.update_attributes(:matri_result => 'Rechazado por Transbank, Aceptado el rechazo por Matriclick')
      end
    end  
    render :text => notify.acknowledge
  end
  
  def success
    if @oc.tbk_tipo_pago == 'VD'
      @tipo_pago = 'Redcompra'
      @tipo_cuotas = 'Venta Débito'
    else
      @tipo_pago = 'Crédito'
      if @oc.tbk_tipo_pago == 'VN'
        @tipo_cuotas = 'Sin cuotas'
      end
      if @oc.tbk_tipo_pago == 'VC'
        @tipo_cuotas = 'Cuotas Normales'
      end
      if @oc.tbk_tipo_pago == 'SI' or @oc.tbk_tipo_pago == 'S2'
        @tipo_cuotas = 'Sin Interés'
      end
      if @oc.tbk_tipo_pago == 'CI'
        @tipo_cuotas = 'Cuotas Comercio'
      end
      if @tipo_pago.nil?
        @tipo_cuotas = 'No Determinado'
      end
    end
    if @oc.tbk_numero_cuotas.nil? or @oc.tbk_numero_cuotas == '0'
      @numero_cuotas = '00'
    else
      @numero_cuotas = @oc.tbk_numero_cuotas
    end
    
    @purchase = @oc.purchase
    #Cada vez que se actualizan funds_received a true se envía un correo a las tiendas que corresponda con el producto que se compró
    @purchase.funds_received = true     
    purchase_actions
  end
  
  def success_transfer
    @purchase = Purchase.find params[:purchase_id]
    purchase_actions
    redirect_to user_profile_path
  end
  
  def success_full_credit
    @purchase = Purchase.find params[:purchase_id]
    purchase_actions
  end
  
  def purchase_actions
    if !@purchase.nil?
      @purchasable = @purchase.purchasable
      if @purchase.status != 'finalizado'
        case @purchasable.class.to_s
          when 'Dress'
            @purchasable.mark_as_sold(@purchase.size, @purchase.quantity)
          else
            @purchasable.mark_as_sold
        end
          
        @purchase.status = 'finalizado'
        @purchase.save(:validate => false)
        
        #REDUCE LOS CRÉDITOS QUE CORRESPONDEN A LA COMPRA
        generate_credit_reduction(@purchase)
    
        #GENERA LOS CRÉDITOS DE PREMIO EN EL CASO DE PAGO WEBPAY (acción success)
        #generate_credit(@purchase) #if action_name == 'success'
        
        #ENVÍA EL CORREO PARA AVISAR QUE OCURRIÓ UNA COMPRA
        NoticeMailer.purchase_email(@purchase).deliver
        
        check_if_came_from_junta
      end
    end
  end
  
  def failure
  end
  
  def get_order_and_log_user_back
    @oc = Order.where(:tbk_orden_compra => params['TBK_ORDEN_COMPRA']).first
    if !@oc.purchase.nil?
      @user = @oc.purchase.user
    else
      @user = @oc.user
    end
    sign_in(@user)
  end
  
  private 
  
  #FUNCIÓN PARA GENERAR LOS CRÉDITOS CUANDO SE REALIZA UNA COMPRA
  def generate_credit(purchase)
    if purchase.price > 15000 and purchase.user.is_first_purchase
      credit_value = 5000
      @formula = '$5000 por primera compra'
      expiration_date = DateTime.now + 3.month
      @credit = Credit.create(:purchase_id => purchase.id, :value => credit_value, :user_id => purchase.user_id, :formula => @formula, :expiration_date => expiration_date, :active => true)
    end
  end
  
  #FUNCIÓN PARA DESCONTAR LOS CRÉDITOS DE UNA COMPRA
  def generate_credit_reduction(purchase)
    purchasable = purchase.purchasable
    
    case purchase.purchasable_type
      when 'Dress', 'GiftCardCode', 'ShoppingCart'
        if !purchase.quantity.blank?
          subtotal = purchasable.price * purchase.quantity
        else
          subtotal = @purchasable.price
        end
      when 'Product', 'Service'
        subtotal = session[:matriclick_purchase_price] if !session[:matriclick_purchase_price].blank?
    end
    
    if purchase.user.credit_amount > subtotal
			credits_to_use = subtotal
		else
			credits_to_use = current_user.credit_amount
		end
    
    if credits_to_use > 0
      active_credits = purchase.user.credits.is_active
      
      active_credits.each do |ac|
        if ac.available_credit > credits_to_use
          @credit_reduction = CreditReduction.create(:credit_id => ac.id, :purchase_id => purchase.id, 
                              :value => credits_to_use, :used_date => DateTime.now)
          return 'Credits still available'
        else
          ac.update_attributes(:active => false)
          @credit_reduction = CreditReduction.create(:credit_id => ac.id, :purchase_id => purchase.id, 
                              :value => ac.available_credit, :used_date => DateTime.now)
          credits_to_use = credits_to_use - ac.available_credit
        end
      end
      return 'All credits used'
    end
  end

  def check_if_came_from_junta
    if session[:junta].present?
      uri = URI.parse("https://junta.cl/cashback")
      args = {apikey: 'zKDvkvmusejH4tn1XBoh5w', token: session[:junta], transaction_id: @purchase.id, amount: @purchase.products_in_purchase_price }
      uri.query = URI.encode_www_form(args)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      
      if response.code == '200'
        # Everything OK
      else
        # Oops...
      end
    end 
  end
  
end

