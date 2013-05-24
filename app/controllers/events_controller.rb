class EventsController < ApplicationController

  before_filter :check_supplier, :set_supplier_layout, :find_supplier
=begin BORRAR SI ES QUE NO SE CAE LA APLICACIÓN POR UN TIEMPO
  def index    
    @events = Event.by_services(@supplier.supplier_account.service_ids)
    @services = @supplier.supplier_account.services
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  def show
    @event = Event.find params[:id]
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  def new
    @services = @supplier.supplier_account.services
    @event = Event.new  

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  def edit
    @event = Event.find params[:id]
    @services = @supplier.supplier_account.services
  end

  def create
    @event = Event.new params[:event]

    respond_to do |format|
      if @event.save
        @supplier.supplier_account.events << @event
        format.html { redirect_to(calendar_supplier_account_url(@supplier),:notice => "#{t('activerecord.successful.messages.created', :model =>  @event.class.model_name.human)}" )}
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        @services = @supplier.supplier_account.services
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])
    if params[:confirm]
    	@event.booking_confirmed = true
    end
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to calendar_supplier_account_url(@supplier), :notice => "#{t('activerecord.successful.messages.updated', :model =>  @event.class.model_name.human)}"  }     
        format.xml  { head :ok }
        format.js { head :ok}
      else
        @services = @supplier.supplier_account.services
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end
=end
#Todo lo relacionado a los bookings que realizan los Proveedores
  def update_booking_confirmed
  	@booking = Booking.find params[:id]

  	@booking.read_status :only_supplier => true
	
  	@booking.status = Booking::STATUS[:confirmed]
	
  	# FGM: Register this confirmed booking as a budget item (check budget_slot presence)
  	if @booking.user_account.budget_slots.find_by_industry_category_id(@booking.bookable.industry_category_id).present?
  		budget = Budget.new user_account_id: @booking.user_account_id, budgetable_type: @booking.bookable_type, budgetable_id: @booking.bookable_id, industry_category_id: @booking.bookable.industry_category_id, supplier_account_id: @booking.supplier_account_id, budget_slot_id: @booking.user_account.budget_slots.find_by_industry_category_id(@booking.bookable.industry_category_id).id
  		budget.save
  	end
	
  	respond_to do |format|
  		if @booking.save
    		format.html {redirect_to :back, :notice => "#{t('activerecord.successful.messages.updated', :model =>  @booking.class.model_name.human)}"}
  		end
  	end
  end
=begin
  def destroy # this is use to expire the booking, but the event is not destroyed from de DB
  	@event = Event.find params[:id]
  	if @event.created_at < 14.days.ago
  		@event.expired = true	
  	end
  	@event.save

    respond_to do |format|
      format.html { redirect_to(calendar_supplier_account_url(@supplier, :anchor => :bookings_list)) }
      format.xml  { head :ok }
    end
  end
=end
  #POST
  def update_soft_delete # DZF just update soft_delete to true
  	@booking = Booking.find params[:id]
		params[:booking].present? ? @booking.update_attributes(params[:booking]) : @booking.update_attribute(:status, Booking::STATUS[:destroyed])
		@booking.read_status :only_supplier => true
		
  	respond_to do |format|
			format.html {redirect_to :back }
  	end
  end
end
