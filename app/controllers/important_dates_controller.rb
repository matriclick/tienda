class ImportantDatesController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier

  def index
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @important_date }
    end
  end

  def new
    @important_date = ImportantDate.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
    end
  end
  
  def edit
    @important_date = ImportantDate.find params[:id]
  end
  
  def create
      @important_date = ImportantDate.create(params[:important_date])
      @important_date.supplier_account_id = @supplier.supplier_account.id

    respond_to do |format|
      if @important_date.save
        format.html { redirect_to supplier_account_important_dates_url(@supplier), :notice => "#{t('activerecord.successful.messages.created', :model =>  @important_date.class.model_name.human)}"  }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update    
    @important_date = ImportantDate.find params[:id]
    @important_date.supplier_account_id = @supplier.supplier_account.id

    respond_to do |format|
      if @important_date.update_attributes(params[:important_date])
        format.html { redirect_to supplier_account_important_dates_url(@supplier), :notice => "#{t('activerecord.successful.messages.updated', :model =>  @important_date.class.model_name.human)}"  }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @important_date = ImportantDate.find params[:id]
    @important_date.destroy
    respond_to do |format|
      format.html { redirect_to supplier_account_important_dates_url(@supplier) }
      format.json { head :ok }
    end
  end
end
