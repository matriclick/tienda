# encoding: UTF-8
class DressStockChangeNotificationsController < ApplicationController
  before_filter :redirect_unless_admin, :generate_bread_crumbs, :except => [:new, :create]
  
  # GET /dress_stock_change_notifications
  # GET /dress_stock_change_notifications.json
  def index
    add_breadcrumb "Lista de espera de productos", :dress_stock_change_notifications_path
    @dress_stock_change_notifications = DressStockChangeNotification.order 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dress_stock_change_notifications }
    end
  end

  # GET /dress_stock_change_notifications/1
  # GET /dress_stock_change_notifications/1.json
  def show
    @dress_stock_change_notification = DressStockChangeNotification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dress_stock_change_notification }
    end
  end

  # GET /dress_stock_change_notifications/new
  # GET /dress_stock_change_notifications/new.json
  def new
    @dress_stock_change_notification = DressStockChangeNotification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dress_stock_change_notification }
    end
  end

  # GET /dress_stock_change_notifications/1/edit
  def edit
    @dress_stock_change_notification = DressStockChangeNotification.find(params[:id])
  end

  # POST /dress_stock_change_notifications
  # POST /dress_stock_change_notifications.json
  def create
    @dress_stock_change_notification = DressStockChangeNotification.new(params[:dress_stock_change_notification])

    respond_to do |format|
      if @dress_stock_change_notification.save
        format.html { redirect_to dress_ver_path(:type => @dress_stock_change_notification.dress.dress_type.name, :slug => @dress_stock_change_notification.dress.slug), notice: '<b>¡Alerta creada exitosamente!</b> Te estaremos contactando.' }
        format.json { render json: @dress_stock_change_notification, status: :created, location: @dress_stock_change_notification }
      else
        format.html { redirect_to dress_ver_path(:type => @dress_stock_change_notification.dress.dress_type.name, :slug => @dress_stock_change_notification.dress.slug), notice: '<b>No se ha creado la solicitud.</b> Como mínimo debes agregar la talla y tu correo.' }
        format.json { render json: @dress_stock_change_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dress_stock_change_notifications/1
  # PUT /dress_stock_change_notifications/1.json
  def update
    @dress_stock_change_notification = DressStockChangeNotification.find(params[:id])

    respond_to do |format|
      if @dress_stock_change_notification.update_attributes(params[:dress_stock_change_notification])
        format.html { redirect_to @dress_stock_change_notification, notice: 'Dress stock change notification was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @dress_stock_change_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dress_stock_change_notifications/1
  # DELETE /dress_stock_change_notifications/1.json
  def destroy
    @dress_stock_change_notification = DressStockChangeNotification.find(params[:id])
    @dress_stock_change_notification.destroy

    respond_to do |format|
      format.html { redirect_to dress_stock_change_notifications_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
  end
  
end
