# encoding: UTF-8
require "prawn"
class GiftCardsController < ApplicationController
  prawnto :prawn => { :page_size => [612.283464567, 790.866141732] }

  # ---- ACTION FOR USERS WITH BOUGHT COUPONS OR ADMINS------
  def show_coupon
    @gift_card_code = GiftCardCode.find(params[:id])
    redirect_unless_owner_or_admin(@gift_card_code)
    
    @gift_card = @gift_card_code.gift_card
    @dresses_from_price_range = @gift_card.supplier_account.dresses.where('price >= ? and price <= ?', @gift_card.min_price, @gift_card.max_price)
    
    @dresses_all = Array.new
    @dresses_from_price_range.each do |dress|
      @dresses_all << dress
    end
    @gift_card.dresses.each do |dress|
      @dresses_all << dress
    end
  end
  
  def view_coupon
    @gift_card_code = GiftCardCode.find(params[:id])
    redirect_unless_owner_or_admin(@gift_card_code)
    
    @gift_card = @gift_card_code.gift_card
    respond_to do |format|
      format.pdf  { render :layout => false  }
    end
  end
  # END OF ---- ACTION FOR USERS WITH BOUGHT COUPONS OR ADMINS------
      
  # GET /gift_cards
  # GET /gift_cards.json
  def index
    redirect_unless_admin_or_supplier
    
    @is_supplier = !current_supplier.nil?
    
    if @is_supplier
      set_supplier_layout
      @supplier = current_supplier
      @gift_cards = @supplier.supplier_account.gift_cards
    else
      if user_signed_in?
        if !current_user.matriclicker.nil?
          hide_left_menu
        end
      end
      @gift_cards = GiftCard.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gift_cards }
    end
  end

  # GET /gift_cards/1
  # GET /gift_cards/1.json
  def show
    redirect_unless_admin_or_supplier
    
    @is_supplier = !current_supplier.nil?

    @gift_card = GiftCard.find(params[:id])
        
    if @is_supplier
      set_supplier_layout
      @supplier = current_supplier
      if !@supplier.supplier_account.gift_cards.include?(@gift_card)
        redirect_to :back
      end
    elsif user_signed_in?
      if !current_user.matriclicker.nil?
        hide_left_menu
      end
    end

    @dresses_from_price_range = @gift_card.supplier_account.dresses.where('price >= ? and price <= ?', @gift_card.min_price, @gift_card.max_price)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gift_card }
    end
  end
  
  # GET /gift_cards/new
  # GET /gift_cards/new.json
  def new
    redirect_unless_admin
    hide_left_menu
    
    @gift_card = GiftCard.new
    @type = SupplierAccountType.find_by_name("Vestidos Boutique")
    @supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).where("supplier_account_type_id = ?", @type.id).approved
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gift_card }
    end
  end
  
  # GET /gift_cards/1/edit
  def edit
    redirect_unless_admin
    hide_left_menu

    @gift_card = GiftCard.find(params[:id])
    @type = SupplierAccountType.find_by_name("Vestidos Boutique")
    @supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).where("supplier_account_type_id = ?", @type.id).approved
  end

  # POST /gift_cards
  # POST /gift_cards.json
  def create
    redirect_unless_admin
    hide_left_menu

    @gift_card = GiftCard.new(params[:gift_card])

    respond_to do |format|
      if @gift_card.save
        format.html { redirect_to @gift_card, notice: 'Gift card was successfully created.' }
        format.json { render json: @gift_card, status: :created, location: @gift_card }
      else
        @type = SupplierAccountType.find_by_name("Vestidos Boutique")
        @supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).where("supplier_account_type_id = ?", @type.id).approved
        
        format.html { render action: "new" }
        format.json { render json: @gift_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gift_cards/1
  # PUT /gift_cards/1.json
  def update
    redirect_unless_admin
    hide_left_menu

    @gift_card = GiftCard.find(params[:id])

    respond_to do |format|
      if @gift_card.update_attributes(params[:gift_card])
        format.html { redirect_to @gift_card, notice: 'Gift card was successfully updated.' }
        format.json { head :ok }
      else
        @type = SupplierAccountType.find_by_name("Vestidos Boutique")
        @supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).where("supplier_account_type_id = ?", @type.id).approved
        
        format.html { render action: "edit" }
        format.json { render json: @gift_card.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_dresses
      redirect_unless_admin
      hide_left_menu

     @gift_card = GiftCard.find(params[:id])
     @dresses = @gift_card.supplier_account.dresses
  end
  
  # POST
  def update_dresses
    redirect_unless_admin
    hide_left_menu

    @gift_card = GiftCard.find(params[:gift_card_id])
    @gift_card.dresses.delete_all
    
    if !params[:dress].nil?
      params[:dress].each do |dress_id|
         dress = Dress.find dress_id[0]
         if @gift_card.dresses.include? dress
           @gift_card.dresses.delete dress
         else
           @gift_card.dresses << dress
         end
       end
      @gift_card.save
    end
    
    redirect_to @gift_card
  end
    
  def gift_card_codes
    redirect_unless_admin
    hide_left_menu
    
     @gift_card = GiftCard.find(params[:id])
     @gift_card_codes = @gift_card.gift_card_codes
  end
  
  def mark_used_code
    redirect_unless_admin_or_supplier
    @is_supplier = !current_supplier.nil?
        
    if @is_supplier #Es el proveedor el que está marcando la Gift Card como usada
      set_supplier_layout
      @supplier = current_supplier
      if !params[:code].empty?
        @gift_card_code = GiftCardCode.find_by_code(params[:code])
        if @gift_card_code.nil?
          redirect_to supplier_account_gift_cards_path(@supplier), :notice => 'ERROR: Código no Encontrado'
        else
          if @gift_card_code.used
            redirect_to supplier_account_gift_cards_path(@supplier), :notice => 'ERROR: Código Usado'
          else
            @gift_card_code.used = true
            @gift_card_code.save
            redirect_to supplier_account_gift_cards_path(@supplier), :notice => 'OK: Código Marcado como Usado'
          end
        end
      else
        redirect_to :back
      end
    else #Es el administrador el que está marcando la Gift Card como usada
      hide_left_menu
      @gift_card_code = GiftCardCode.find(params[:id])
      if @gift_card_code.bought
        @gift_card_code.bought = false
      else
        @gift_card_code.bought = true
      end
      @gift_card_code.save
      redirect_to gift_cards_gift_card_codes_path(:id => @gift_card_code.gift_card.id)
    end
  end
  
  def mark_bought_code
    redirect_unless_admin
    hide_left_menu
    
     @gift_card_code = GiftCardCode.find(params[:id])
     if @gift_card_code.bought
       @gift_card_code.bought = false
     else
       @gift_card_code.bought = true
     end
     @gift_card_code.save
     
     redirect_to gift_cards_gift_card_codes_path(:id => @gift_card_code.gift_card.id)
  end

  # DELETE /gift_cards/1
  # DELETE /gift_cards/1.json
  def destroy
    redirect_unless_admin
    hide_left_menu
    
    @gift_card = GiftCard.find(params[:id])
    @gift_card.destroy

    respond_to do |format|
      format.html { redirect_to gift_cards_url }
      format.json { head :ok }
    end
  end
end
