# encoding: UTF-8
class DeliveryInfosController < ApplicationController
  before_filter :redirect_unless_admin, :only => [:index, :show]
  before_filter :authenticate_user!
  
  # GET /delivery_infos
  # GET /delivery_infos.json
  def index
    hide_left_menu
    
    @delivery_infos = DeliveryInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @delivery_infos }
    end
  end

  # GET /delivery_infos/1
  # GET /delivery_infos/1.json
  def show
    hide_left_menu
    
    @delivery_info = DeliveryInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @delivery_info }
    end
  end

  # GET /delivery_infos/new
  # GET /delivery_infos/new.json
  def new
    @delivery_info = DeliveryInfo.new
    @user = current_user
    if !params[:purchasable_type].nil?
      @object = eval(params[:purchasable_type] + '.find ' + params[:purchasable_id])
    end
  end

  # GET /delivery_infos/1/edit
  def edit
    @delivery_info = DeliveryInfo.find(params[:id])
    @user = current_user
    if !params[:purchasable_type].nil?
      @object = eval(params[:purchasable_type] + '.find ' + params[:purchasable_id])
    end
  end

  # POST /delivery_infos
  # POST /delivery_infos.json
  def create
    @delivery_info = DeliveryInfo.new(params[:delivery_info])
    @user = current_user
    
    if !params[:purchasable][:type].nil?
      @object = eval(params[:purchasable][:type]+'.find '+params[:purchasable][:id])
    end
    
    respond_to do |format|
      if @delivery_info.save
        if !@object.nil?
          format.html { redirect_to buy_details_path(:purchasable_id => params[:purchasable][:id], :purchasable_type => params[:purchasable][:type]) }
        else
          format.html { redirect_to user_profile_information_path }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @delivery_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /delivery_infos/1
  # PUT /delivery_infos/1.json
  def update
    @delivery_info = DeliveryInfo.find(params[:id])
    
    if !params[:purchasable][:type].nil?
      @object = eval(params[:purchasable][:type]+'.find '+params[:purchasable][:id])
    end
    
    respond_to do |format|
      if @delivery_info.update_attributes(params[:delivery_info])
        if !@object.nil?
          format.html { redirect_to buy_details_path(:purchasable_id => params[:purchasable][:id], :purchasable_type => params[:purchasable][:type]) }
        else
          format.html { redirect_to user_profile_information_path }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_infos/1
  # DELETE /delivery_infos/1.json
  def destroy
    @delivery_info = DeliveryInfo.find(params[:id])
    
    if @delivery_info.purchases.size == 0
      @delivery_info.destroy
      msg = 'Dirección eliminada sin problemas'
    else 
      msg = 'No podemos eliminar esta dirección ya que tiene compras relacionadas'
    end
    
    respond_to do |format|
      if !params[:purchasable].nil?
        format.html { redirect_to buy_details_path(:purchasable_id => params[:purchasable][:id], :purchasable_type => params[:purchasable][:type]), notice: msg }
      else
        format.html { redirect_to user_profile_information_path, notice: msg }
      end
    end
  end
end
