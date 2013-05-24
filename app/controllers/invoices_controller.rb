class InvoicesController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  before_filter { redirect_unless_privilege('Finanzas') }
      
  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    @contract = Contract.find params[:contract_id]
    @invoice = Invoice.new(contract_id: @contract.id)
    now =	DateTime.now.month
    @invoice_months = InvoiceMonth.where('month >= ? and year >= ?', now.month, now.year)
    @invoice_months.sort_by! {|im| [im.year, im.month] }      
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
    now =	DateTime.now.month
    @invoice_months = InvoiceMonth.where('month >= ? and year >= ?', now.month, now.year)
    @invoice_months.sort_by! {|im| [im.year, im.month] }    
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(params[:invoice])
    now =	DateTime.now.month
    @invoice_months = InvoiceMonth.where('month >= ? and year >= ?', now.month, now.year)
    @invoice_months.sort_by! {|im| [im.year, im.month] }    
    
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice.contract, notice: 'Invoice was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    @invoice = Invoice.find(params[:id])
    now =	DateTime.now.month
    @invoice_months = InvoiceMonth.where('month >= ? and year >= ?', now.month, now.year)
    @invoice_months.sort_by! {|im| [im.year, im.month] }    
    
    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to @invoice.contract, notice: 'Invoice was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.find(params[:id])
    contract = @invoice.contract
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to contract }
      format.json { head :ok }
    end
  end
  
  # GET
  def download_file
  	@attached_file = AttachedFile.find params[:attached_file]
  	send_file @attached_file.attached.path, :type => @attached_file.attached_content_type, :filename => @attached_file.attached_file_name
  end
  
end
