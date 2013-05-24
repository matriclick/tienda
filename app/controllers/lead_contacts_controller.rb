class LeadContactsController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  
  # GET /lead_contacts
  # GET /lead_contacts.json
  def index
    @lead_contacts = LeadContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lead_contacts }
    end
  end

  # GET /lead_contacts/1
  # GET /lead_contacts/1.json
  def show
    @lead_contact = LeadContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lead_contact }
    end
  end

  # GET /lead_contacts/new
  # GET /lead_contacts/new.json
  def new
    @lead_contact = LeadContact.new
    @lead = Lead.find params[:lead_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lead_contact }
    end
  end

  # GET /lead_contacts/1/edit
  def edit
    @lead_contact = LeadContact.find(params[:id])
    @lead = @lead_contact.lead
  end

  # POST /lead_contacts
  # POST /lead_contacts.json
  def create
    @lead_contact = LeadContact.new(params[:lead_contact])

    respond_to do |format|
      if @lead_contact.save
        format.html { redirect_to @lead_contact.lead, notice: 'Lead contact was successfully created.' }
        format.json { render json: @lead_contact, status: :created, location: @lead_contact }
      else
        format.html { render action: "new" }
        format.json { render json: @lead_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lead_contacts/1
  # PUT /lead_contacts/1.json
  def update
    @lead_contact = LeadContact.find(params[:id])

    respond_to do |format|
      if @lead_contact.update_attributes(params[:lead_contact])
        format.html { redirect_to @lead_contact.lead, notice: 'Lead contact was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @lead_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lead_contacts/1
  # DELETE /lead_contacts/1.json
  def destroy
    @lead_contact = LeadContact.find(params[:id])
    @lead_contact.destroy

    respond_to do |format|
      format.html { redirect_to lead_contacts_url }
      format.json { head :ok }
    end
  end
end
