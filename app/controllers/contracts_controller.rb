class ContractsController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  before_filter { redirect_unless_privilege('Salestool') }
  
  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    @contract = Contract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contract }
    end
  end

  # GET /contracts/new
  # GET /contracts/new.json
  def new
    @lead = Lead.find(params[:lead_id])
    if @lead.lead_contacts.count > 0
      emails = ''
      first = true
      @lead.lead_contacts.each do |contact|
        if first
          emails = contact.email
          first = false
        else
          emails = emails+', '+contact.email
        end
      end
      @contract = Contract.new(:invoice_mailing => emails)
    else
      @contract = Contract.new
    end
  
    @months = []
    for i in 0..18
      @months << [i,i]
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contract }
    end
  end

  # GET /contracts/1/edit
  def edit
    @contract = Contract.find(params[:id])
    @lead = @contract.lead
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(params[:contract])
    @lead = Lead.find(params[:contract][:lead_id])
    
    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract.lead, notice: 'Contract was successfully created.' }
        format.json { render json: @contract, status: :created, location: @contract }
      else
        format.html { render action: "new" }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.json
  def update
    @contract = Contract.find(params[:id])

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        format.html { redirect_to @contract.lead, notice: 'Contract was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract = Contract.find(params[:id])
    @lead = @contract.lead
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to @lead }
      format.json { head :ok }
    end
  end
  
  # GET
  def download_file
  	@attached_file = AttachedFile.find params[:attached_file]
  	send_file @attached_file.attached.path, :type => @attached_file.attached_content_type, :filename => @attached_file.attached_file_name
  end
  
end
