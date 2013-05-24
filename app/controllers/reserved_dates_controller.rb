class ReservedDatesController < ApplicationController
  before_filter :authenticate_supplier!, :set_supplier_layout, :find_supplier
  # GET /reserved_dates
  # GET /reserved_dates.json
  def index
    @reserved_dates = ReservedDate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reserved_dates }
    end
  end

  # GET /reserved_dates/1
  # GET /reserved_dates/1.json
  def show
    @reserved_date = ReservedDate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reserved_date }
    end
  end

  # GET /reserved_dates/new
  # GET /reserved_dates/new.json
  def new
    @supplier = Supplier.find params[:id]
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    @reserved_date = ReservedDate.new

    respond_to do |format|
      format.html {render :layout => false}
      format.json { render json: @reserved_date }
    end
  end

  # GET /reserved_dates/1/edit
  def edit
    @reserved_date = ReservedDate.find(params[:id])
    @date = @reserved_date.date
    @supplier = @reserved_date.supplier_account.supplier
        
    respond_to do |format|
      format.html {render :layout => false}
      format.json { render json: @reserved_date }
    end
    
  end

  # POST /reserved_dates
  # POST /reserved_dates.json
  def create
    @reserved_date = ReservedDate.new(params[:reserved_date])
    @supplier = @reserved_date.supplier_account.supplier
    
    respond_to do |format|
      if @reserved_date.save
        format.html { redirect_to calendar_supplier_account_path(@supplier), notice: 'Reserva creada exitosamente' }
        format.json { render json: calendar_supplier_account_path(@supplier), status: :created, location: @reserved_date }
      else
        format.html { render action: "new" }
        format.json { render json: @reserved_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reserved_dates/1
  # PUT /reserved_dates/1.json
  def update
    @reserved_date = ReservedDate.find(params[:id])
    @supplier = @reserved_date.supplier_account.supplier
    
    respond_to do |format|
      if @reserved_date.update_attributes(params[:reserved_date])
        format.html { redirect_to calendar_supplier_account_path(@supplier), notice: 'Reserva modificada exitosamente' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reserved_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reserved_dates/1
  # DELETE /reserved_dates/1.json
  def destroy
    @reserved_date = ReservedDate.find(params[:id])
    @supplier = @reserved_date.supplier_account.supplier
    @reserved_date.destroy

    respond_to do |format|
      format.html { redirect_to calendar_supplier_account_path(@supplier), notice: 'Reserva eliminada' }
      format.json { head :ok }
    end
  end
end
