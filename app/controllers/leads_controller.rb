class LeadsController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  before_filter { redirect_unless_privilege('Salestool') }
  
  # GET /leads
  # GET /leads.json
  def index
    
    if !current_user.matriclicker.nil?
      @matriclicker = current_user.matriclicker
    end
    
    @search_term = params[:q]
  
    if @search_term.nil? or @search_term.empty?
      @leads = Lead.where(:country_id => session[:country].id)
    else
      @leads = Lead.where(:country_id => session[:country].id).joins(:matriclicker).joins(:industry_category).joins(:lead_contacts).
      where('leads.name like "%'+@search_term+'%" or matriclickers.name like "%'+@search_term+'%" or industry_categories.name like "%'+@search_term+'%" or lead_contacts.name like "%'+@search_term+'%"')
      .uniq;
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leads }
    end
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
    if !current_user.matriclicker.nil?
      @matriclicker = current_user.matriclicker
    end
    
    @lead = Lead.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lead }
    end
  end

  # GET /leads/new
  # GET /leads/new.json
  def new
    @lead = Lead.new
    @matriclicker = current_user.matriclicker
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lead }
    end
  end

  # GET /leads/1/edit
  def edit
    @lead = Lead.find(params[:id])
    @matriclicker = @lead.matriclicker
    @edit_owner = check_privilege('Leads')
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(params[:lead])
    @matriclicker = current_user.matriclicker

    respond_to do |format|
      if @lead.save
        format.html { redirect_to @lead, notice: 'Lead was successfully created.' }
        format.json { render json: @lead, status: :created, location: @lead }
      else
        format.html { render action: "new" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leads/1
  # PUT /leads/1.json
  def update
    @lead = Lead.find(params[:id])
    @matriclicker = current_user.matriclicker

    respond_to do |format|
      if @lead.update_attributes(params[:lead])
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    redirect_unless_privilege('Tecnologia')
    @lead = Lead.find(params[:id])
    @lead.destroy

    respond_to do |format|
      format.html { redirect_to leads_url }
      format.json { head :ok }
    end
  end
end
