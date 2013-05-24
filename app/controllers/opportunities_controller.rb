# encoding: UTF-8
class OpportunitiesController < ApplicationController
  before_filter :redirect_unless_admin, :except => [:index, :show]
  before_filter :hide_left_menu, :except => [:index, :show]
  add_breadcrumb "Ofertas de la Semana", :opportunities_path
  
  # GET /opportunities
  # GET /opportunities.json
  def index
    @opportunities = Opportunity.where('valid_until >= ?', Time.now)
    @opportunities_admin = Opportunity.all   
    
    @title_content = 'Ofertas en Servicios para tu Matrimonios'
  	@meta_description_content = 'Ofertas por tiempo limitado para contratar servicios como DJs, Maquillaje y muchas cosas más para tu matrimonio'
  	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @opportunities }
    end
  end

  # GET /opportunities/1
  # GET /opportunities/1.json
  def show
    @opportunity = Opportunity.find(params[:id])
    add_breadcrumb @opportunity.title, @opportunity
    #HH -> Esto hay que hacerlo porque existen productos y servicios que pueden estar relacionados a un proveedor
    #Es un error legado de Redvel
    @object = @opportunity.supplier_account.products.first

    @title_content = @opportunity.title
  	@meta_description_content = @opportunity.description

    if @object.nil?
      @object = @opportunity.supplier_account.services.first
    end
        
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @opportunity }
    end
  end

  # GET /opportunities/new
  # GET /opportunities/new.json
  def new
    @opportunity = Opportunity.new
    @supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).approved.order 'fantasy_name'
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @opportunity }
    end
  end

  # GET /opportunities/1/edit
  def edit
    @opportunity = Opportunity.find(params[:id])
    @supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).approved.order 'fantasy_name'
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    @opportunity = Opportunity.new(params[:opportunity])

    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully created.' }
        format.json { render json: @opportunity, status: :created, location: @opportunity }
      else
        @supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).approved.order 'fantasy_name'
        
        format.html { render action: "new" }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /opportunities/1
  # PUT /opportunities/1.json
  def update
    @opportunity = Opportunity.find(params[:id])

    respond_to do |format|
      if @opportunity.update_attributes(params[:opportunity])
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully updated.' }
        format.json { head :ok }
      else
        @supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).approved.order 'fantasy_name'
        
        format.html { render action: "edit" }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.json
  def destroy
    @opportunity = Opportunity.find(params[:id])
    @opportunity.destroy

    respond_to do |format|
      format.html { redirect_to opportunities_url }
      format.json { head :ok }
    end
  end
end
